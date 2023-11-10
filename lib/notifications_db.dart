import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class BaseNotification {
  final String title;
  final String body;
  final DateTime time;
  final bool isRead;

  BaseNotification(
      {required this.title,
      required this.body,
      required this.time,
      this.isRead = false});
}

class OrderNotification extends BaseNotification {
  final String orderId;
  final String orderStatus;
  final String orderStatusAr;
  final String userId;

  OrderNotification(
      {required this.orderId,
      required this.orderStatus,
      required this.orderStatusAr,
      required String title,
      required this.userId,
      required String body,
      bool isRead = false,
      required DateTime time})
      : super(title: title, body: body, time: time, isRead: isRead);

  factory OrderNotification.fromMap(Map<String, dynamic> map) {
    return OrderNotification(
      orderId: map['orderId'],
      orderStatus: map['orderStatus'],
      orderStatusAr: map['orderStatusAr'],
      title: map['title'],
      body: map['body'],
      isRead: map['isRead'] ?? true,
      userId: map['userId'],
      time: DateTime.parse(map['time']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isRead': isRead,
      'orderId': orderId,
      'orderStatus': orderStatus,
      'orderStatusAr': orderStatusAr,
      'title': title,
      'userId': userId,
      'body': body,
      'time': time.toIso8601String(),
    };
  }

  // from remote message
  factory OrderNotification.fromRemoteMessage(RemoteMessage message) {
    return OrderNotification(
      orderId: message.data['orderId'],
      userId: message.data['userId'],
      orderStatus: message.data['orderStatus'],
      orderStatusAr: message.data['orderStatusAr'],
      title: message.notification!.title!,
      body: message.notification!.body!,
      time: DateTime.now(),
      isRead: false,
    );
  }
  // to remote message
  RemoteMessage toRemoteMessage() {
    return RemoteMessage(
      data: {
        'orderId': orderId,
        'orderStatus': orderStatus,
        'orderStatusAr': orderStatusAr,
        'userId': userId,
      },
      notification: RemoteNotification(
        title: title,
        body: body,
      ),
    );
  }
}

class NotificationsDB {
  // singlton class
  NotificationsDB._();
  static final instance = NotificationsDB._();
  // firebase
  final _db = FirebaseFirestore.instance;

  Future<void> addNotification(
      {required OrderNotification notification}) async {
    // if exist update it
    await _db
        .collection('notifications')
        .where('orderId', isEqualTo: notification.orderId)
        .get()
        .then((snap) async {
      if (snap.docs.isNotEmpty) {
        for (var doc in snap.docs) {
          await doc.reference.update(notification.toMap());
        }
      } else {
        await _db.collection('notifications').add(notification.toMap());
      }
    });
  }

  // get user notifications
  Stream<List<BaseNotification>> getUserNotifications(String userId) {
    return _db
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => OrderNotification.fromMap(doc.data()))
            .toList());
  }

  // update notification as read
  Future<void> updateNotification(String notificationId) async {
    await _db
        .collection('notifications')
        .doc(notificationId)
        .update({'isRead': true});
  }

  // update all notifications as read
  Future<void> updateAllNotifications(String userId) async {
    await _db
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .get()
        .then((snap) {
      for (var doc in snap.docs) {
        doc.reference.update({'isRead': true});
      }
    });
  }

  // update notification status
  Future<void> updateNotificationStatus(
      {required String notificationId, required String status}) async {
    await _db
        .collection('notifications')
        .doc(notificationId)
        .update({'orderStatus': status});
  }

  // delete user notification if order is deleted
  Future<void> deleteNotification(String notificationId) async {
    await _db.collection('notifications').doc(notificationId).delete();
  }

  // if user notificaiton is more than 20 delete the oldest one
  Future<void> deleteOldestNotification(String userId) async {
    await _db
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('time')
        .limit(1)
        .get()
        .then((snap) {
      for (var doc in snap.docs) {
        doc.reference.delete();
      }
    });
  }
}
