import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stockat/fcm_provider.dart';
import 'package:stockat/notifications_db.dart';
import 'package:stockat/service/order_service.dart';

import '../../main.dart';

class OrdersHistoryProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  OrdersHistoryProvider() {
    if (isAdmin) {
      statuses.add(OrderStatusKeys.cancelled);
    }
  }
  // bool isAdmin = false;
  List<String> statuses = [
    OrderStatusKeys.pending,
    OrderStatusKeys.processing,
    OrderStatusKeys.shipped,
    OrderStatusKeys.delivered,
  ];
  // selected status
  String _status = OrderStatusKeys.pending;

  String get status => _status;

  set status(String status) {
    _status = status;
    fetchOrders();
    notifyListeners();
  }

  final OrderService _orderService = OrderService();

  List<Order> _orders = [];

  List<Order> get orders => _orders;

  set orders(List<Order> orders) {
    _orders = orders;
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    isLoading = true;
    orders = await _orderService.fetchOrders(
      userId: isAdmin ? null : FirebaseAuth.instance.currentUser!.uid,
      status: status,
    );
    isLoading = false;
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
  }) async {
    await _orderService.updateOrderStatus(
      orderId,
      status,
    );
    await fetchOrders();
  }

  Future<void> deleteOrder(String orderId) async {
    await _orderService.deleteOrder(orderId);
    await fetchOrders();
  }

  String getActionText(
    String status,
  ) {
    switch (status) {
      case OrderStatusKeys.pending:
        return 'Process';
      case OrderStatusKeys.processing:
        return 'Ship';
      case OrderStatusKeys.shipped:
        return 'Deliver';
      // case OrderStatusKeys.delivered:
      //   return 'Cancel';
      case OrderStatusKeys.cancelled:
        return 'Delete';
      default:
        return '';
    }
  }

  String getBodyText(newStatus) {
    switch (newStatus) {
      case OrderStatusKeys.pending:
        return 'Yor order is pending';
      case OrderStatusKeys.processing:
        return 'Yor order is processing';
      case OrderStatusKeys.shipped:
        return 'Yor order is shipped';
      case OrderStatusKeys.delivered:
        return 'Yor order is delivered';
      case OrderStatusKeys.cancelled:
        return 'Yor order is cancelled';
      default:
        return '';
    }
  }

  Future<void> updateOrderStatusAction(String orderId, String? userId) async {
    String newStatus = '';
    switch (status) {
      case OrderStatusKeys.pending:
        newStatus = OrderStatusKeys.processing;
        await updateOrderStatus(
            orderId: orderId, status: OrderStatusKeys.processing);
        break;
      case OrderStatusKeys.processing:
        newStatus = OrderStatusKeys.shipped;
        await updateOrderStatus(
            orderId: orderId, status: OrderStatusKeys.shipped);
        break;
      case OrderStatusKeys.shipped:
        newStatus = OrderStatusKeys.delivered;
        await updateOrderStatus(
            orderId: orderId, status: OrderStatusKeys.delivered);
        break;
      case OrderStatusKeys.delivered:
        newStatus = OrderStatusKeys.cancelled;
        await updateOrderStatus(
            orderId: orderId, status: OrderStatusKeys.cancelled);
        break;
      case OrderStatusKeys.cancelled:
        newStatus = OrderStatusKeys.cancelled;
        await deleteOrder(orderId);
        break;
    }
    final OrderNotification notification = OrderNotification(
      orderId: orderId,
      userId: userId!,
      orderStatus: status,
      orderStatusAr: status,
      title: 'Order Status',
      body: getBodyText(newStatus),
      time: DateTime.now(),
    );

    FcmProvider()
        .sendNotification(
          userId: userId ??
              orders.firstWhere((element) => element.id == orderId).userId,
          title: notification.title,
          body: notification.body,
          data: notification.toRemoteMessage().data,
        )
        .then((value) => print('Notification sent'));
  }

  // user cancel order
  Future<void> cancelOrder(String orderId) async {
    await _orderService.updateOrderStatus(
      orderId,
      OrderStatusKeys.cancelled,
    );
    await fetchOrders();
    // get the name of the user owner of the order
    final _order = orders.firstWhere((element) => element.id == orderId);
    final _user = await AuthService().getUserProfile(_order.userId);
    final userName = _user.name;
    // send notification to admin
    final OrderNotification notification = OrderNotification(
      orderId: orderId,
      userId: FirebaseAuth.instance.currentUser!.uid,
      orderStatus: OrderStatusKeys.cancelled,
      orderStatusAr: OrderStatusKeys.cancelled,
      title: 'Order is cancelled ',
      body: '$userName cancelled order',
      time: DateTime.now(),
    );
    // get admins tokens
    final _admins = await AuthService().getAdminsProfiles();

    for (var element in _admins) {
      FcmProvider()
          .sendNotification(
            userId: element.id!,
            title: notification.title,
            body: notification.body,
            data: notification.toRemoteMessage().data,
          )
          .then((value) => print('Notification sent'));
    }

    // FcmProvider()
    //     .sendNotification(
    //       userId: orders.firstWhere((element) => element.id == orderId).userId,
    //       title: notification.title,
    //       body: notification.body,
    //       data: notification.toRemoteMessage().data,
    //     )
    //     .then((value) => print('Notification sent'));
  }
}
