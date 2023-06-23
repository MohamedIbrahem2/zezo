import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:stockat/service/product_service.dart';
import 'package:stockat/view/my_page_screens/oreder_history.dart';

import 'cart_service.dart';

class Order {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime orderDate;
  final String address; // New field for address
  final DateTime deliveryDate; // New field for delivery date

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    required this.address,
    required this.deliveryDate,
  });

  factory Order.fromSnapshot(DocumentSnapshot snapshot) {
    try {
      final data = snapshot.data() as Map<String, dynamic>;
      final itemList = data['items'] as List<dynamic>;
      final cartItems = itemList.map((item) => CartItem.fromMap(item)).toList();
      return Order(
        id: snapshot.id,
        userId: data['userId'],
        items: cartItems,
        totalAmount: data['totalAmount'],
        orderDate: (data['orderDate'] as Timestamp).toDate(),
        address: data['address'], // Assign address value from snapshot data
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
      items: cartItems,
      totalAmount: data['totalAmount'],
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      address: data['address'], // Assign address value from snapshot data
      deliveryDate: (data['deliveryDate'] as Timestamp)
          .toDate(), // Assign delivery date value from snapshot data
    );
  }
}

class OrderService {
  Future<void> placeOrder(String userId, List<CartItem> items,
      double totalAmount, String address, DateTime deliveryDate) async {
    final collection = FirebaseFirestore.instance.collection('orders');
    final orderDate = DateTime.now();
    await collection.add({
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'address': address, // Add address value to the order
      'deliveryDate': deliveryDate, // Add delivery date value to the order
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
    Get.to(OrderHistory());
  }

  Stream<List<Order>> getOrders() {
    final collection = FirebaseFirestore.instance.collection('orders');
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Order>> getOrdersByUser(String userId) {
    final collection = FirebaseFirestore.instance.collection('orders');
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
}
