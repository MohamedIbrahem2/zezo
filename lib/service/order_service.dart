import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:stockat/service/address_service.dart';
import 'package:stockat/service/product_service.dart';
import 'package:stockat/view/my_page_screens/oreder_history.dart';
import 'package:uuid/uuid.dart';

import 'cart_service.dart';

class OrderStatusKeys {
  static const String pending = 'pending';
  static const String processing = 'processing';
  static const String shipped = 'shipped';
  static const String delivered = 'delivered';
  static const String cancelled = 'cancelled';
}

class Order {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime orderDate;
  final Address? address; // New field for address
  final DateTime deliveryDate; // New field for delivery date
  final String? status;
  final String? invoiceNumber;

  Order(
      {required this.id,
      required this.userId,
      required this.items,
      required this.totalAmount,
      required this.orderDate,
      this.address,
      this.invoiceNumber,
      required this.deliveryDate,
      this.status});

  factory Order.fromSnapshot(DocumentSnapshot snapshot) {
    try {
      final data = snapshot.data() as Map<String, dynamic>;
      final itemList = data['items'] as List<dynamic>;
      final cartItems = itemList.map((item) => CartItem.fromMap(item)).toList();
      return Order(
        id: snapshot.id,
        userId: data['userId'],
        invoiceNumber: data['invoiceNumber'],
        items: cartItems,
        totalAmount: data['totalAmount'],
        orderDate: (data['orderDate'] as Timestamp).toDate(),
        status: data['status'],
        address: data['address'] == null
            ? null
            : data['address'] is String
                ? null
                : Address.fromMap(
                    data['address']), // Assign address value from snapshot data
        deliveryDate: (data['deliveryDate'] as Timestamp)
            .toDate(), // Assign delivery date value from snapshot data
      );
    } catch (e, s) {
      print(e);
      print(s);
    }
    final data = snapshot.data() as Map<String, dynamic>;
    final itemList = data['items'] as List<dynamic>;
    final cartItems = itemList.map((item) => CartItem.fromMap(item)).toList();
    return Order(
      id: snapshot.id,
      userId: data['userId'],
      invoiceNumber: data['invoiceNumber'],
      status: data['status'],
      items: cartItems,
      totalAmount: data['totalAmount'],
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      address: Address.fromMap(
          data['address']), // Assign address value from snapshot data
      deliveryDate: (data['deliveryDate'] as Timestamp)
          .toDate(), // Assign delivery date value from snapshot data
    );
  }
}

class OrderService {
  Future<void> placeOrder(String userId, List<CartItem> items,
      double totalAmount, Address address, DateTime deliveryDate) async {
    final collection = FirebaseFirestore.instance.collection('orders');
    final orderDate = DateTime.now();
    await collection.add({
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'status': OrderStatusKeys.pending,
      'address': address.toMap(), // Add address value to the order
      'deliveryDate': deliveryDate, // Add delivery date value to the order
      'invoiceNumber': generateInvoiceNumber(),
    });
// clear cart
    final cartCollection = FirebaseFirestore.instance.collection('cart');
    final cartItems = await cartCollection
        .where('userId', isEqualTo: userId)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) => CartItem.fromSnapshot(doc)).toList();
    });
    for (var item in cartItems) {
      await cartCollection.doc(item.id).delete();
    }

    // go to order page
    await Get.to(const OrderHistory());
    Get.back();
  }

  //fetchOrders
  Future<List<Order>> fetchOrders({String? userId, String? status}) async {
    final collection = FirebaseFirestore.instance.collection('orders');
    if (userId != null && status != null) {
      final querySnapshot = await collection
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: status)
          .get();
      return querySnapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    }
    if (userId != null) {
      final querySnapshot =
          await collection.where('userId', isEqualTo: userId).get();
      return querySnapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    }
    if (status != null) {
      final querySnapshot =
          await collection.where('status', isEqualTo: status).get();
      return querySnapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    }

    final querySnapshot = await collection.get();

    return querySnapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
  }

  Stream<List<Order>> getOrders() {
    final collection = FirebaseFirestore.instance.collection('orders');

    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Order>> getOrdersByUser(String userId, {String? status}) {
    final collection = FirebaseFirestore.instance.collection('orders');
    if (status != null) {
      return collection
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: status)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
      });
    }
    return collection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    });
  }

  Future<void> deleteOrder(String orderId) async {
    final collection = FirebaseFirestore.instance.collection('orders');
    await collection.doc(orderId).delete();
  }

  Future<void> updateOrder(
      String orderId, String address, DateTime deliveryDate) async {
    final collection = FirebaseFirestore.instance.collection('orders');
    await collection.doc(orderId).update({
      'address': address,
      'deliveryDate': deliveryDate,
    });
  }

  Stream<List<Product>> getProductsFromOrder(String orderId) {
    final collection = FirebaseFirestore.instance.collection('orders');
    return collection.doc(orderId).snapshots().asyncMap((snapshot) async {
      final data = snapshot.data() as Map<String, dynamic>;
      final itemList = data['items'] as List<dynamic>;
      final cartItems = itemList.map((item) => CartItem.fromMap(item)).toList();
      final productIds = cartItems.map((item) => item.productId).toList();

      final collection = FirebaseFirestore.instance.collection('products');
      final querySnapshot = await collection
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      return querySnapshot.docs
          .map((doc) => Product.fromSnapshot(doc))
          .toList();
    });
  }

  // proccessing order
  Future<void> updateOrderStatus(String orderId, String status) async {
    final collection = FirebaseFirestore.instance.collection('orders');
    await collection.doc(orderId).update({
      'status': status,
    });
  }

  // shipped order
  Future<void> updateOrderStatusShipped(String orderId) async {
    final collection = FirebaseFirestore.instance.collection('orders');
    await collection.doc(orderId).update({
      'status': OrderStatusKeys.shipped,
    });
  }

  // delivered order
  Future<void> updateOrderStatusDelivered(String orderId) async {
    final collection = FirebaseFirestore.instance.collection('orders');
    await collection.doc(orderId).update({
      'status': OrderStatusKeys.delivered,
    });
  }
}

String generateInvoiceNumber() {
  // current time
  final now = DateTime.now();
  // convert time to milliseconds
  final milliseconds = now.millisecondsSinceEpoch;
  // add random number
  const uuid = Uuid();
  final randomNumber = uuid.v4().substring(0, 4);
  // return invoice number
  return '$milliseconds$randomNumber';
}
