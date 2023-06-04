import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_service.dart';

class Order {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime orderDate;

  Order(
      {required this.id,
      required this.userId,
      required this.items,
      required this.totalAmount,
      required this.orderDate});

  factory Order.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final itemList = data['items'] as List<dynamic>;
    final cartItems = itemList.map((item) => CartItem.fromMap(item)).toList();
    return Order(
      id: snapshot.id,
      userId: data['userId'],
      items: cartItems,
      totalAmount: data['totalAmount'],
      orderDate: (data['orderDate'] as Timestamp).toDate(),
    );
  }
}

class OrderService {
  Future<void> placeOrder(
      String userId, List<CartItem> items, double totalAmount) async {
    final collection = FirebaseFirestore.instance.collection('orders');
    final orderDate = DateTime.now();
    await collection.add({
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
    });
  }

  Stream<List<Order>> getOrders() {
    final collection = FirebaseFirestore.instance.collection('orders');
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    });
  }
}
