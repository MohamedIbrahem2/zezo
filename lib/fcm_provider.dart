import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:stockat/notifications_db.dart';

class FcmProvider {
  static final FcmProvider _instance = FcmProvider._internal();

  factory FcmProvider() => _instance;

  FcmProvider._internal();

  final _firestore = FirebaseFirestore.instance;

  final String serverKey =
      'AAAAqPzP7mI:APA91bFp0h8aIwpfIOEqYcA49RBidh8uDg_ns7hGy9ketdNmQZsysXSeak7mbjCLhuVF9Pv0YBfLl-tXwHOq9nuYoRPc8CIuzu38sEYt9XGFsYYdMBT2iKB74LbBgAxfs8SOYBODNNKs';

  Future<void> sendMessage(List<String> tokens, String message,String title,Function(bool) setLoading) async {
    final body = {
      "registration_ids": tokens,
      "notification": {
        "title": title,
        "body": message,
      },
    };

    try {
      setLoading(true);

      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Get.snackbar('تم الأرسال', 'بنجاح',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green);
      } else {
        Get.snackbar('فشل', 'حدث خطأ ما',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red);
      }
    } catch (e) {
      print('An error occurred while sending the message: $e');
    } finally {
      setLoading(false);
    }
  }
  Future<void> sendHttppNotification(
    String token,
    String title,
    String body,
    Map<String, dynamic> data,
  ) async {
    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=$serverKey'
    };
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: json.encode(
            {
              'notification': {
                'title': title,
                'body': body,
                'sound': 'default',
                'badge': '1',
              },
              'priority': 'high',
              'data': data,
              'to': token,
            },
          ),
          headers: headers);
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  // send notification to topic

  Future<void> sendToTopic(
    String tpic,
    String title,
    String body,
    Map<String, dynamic> data,
  ) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: json.encode(
          {
            'notification': {
              'title': title,
              'body': body,
              'sound': 'default',
              'badge': '1',
            },
            'priority': 'high',
            'data': data,
            'to': '/topics/$tpic',
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }

// subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
    } catch (e) {
      print(e);
    }
  }

  // unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    } catch (e) {
      print(e);
    }
  }

  String? token;

  Future<void> initialize() async {
    // initialize firebase messaging

    await FirebaseMessaging.instance.requestPermission();

    final _token = await FirebaseMessaging.instance.getToken();

    if (_token != null) {
      token = _token;

      saveTokenToFirestore(FirebaseAuth.instance.currentUser!.uid);
    }
  
    FirebaseMessaging.instance.onTokenRefresh.listen((event) async {
      token = event;
      await saveTokenToFirestore(FirebaseAuth.instance.currentUser!.uid);
    });
    listenToNotification();
  }

  Future<void> saveTokenToFirestore(String userId) async {
    // save token to firestore

    try {
      await _firestore.collection('users').doc(userId).update({'fcm': token});
    } catch (e) {
      print('Error adding token: $e');
    }
  }

  // get token
  Future<String?> getUserToken(
    String userId,
  ) async {
    try {
      final _token = await _firestore
          .collection('users')
          .doc(userId)
          .get()
          .then((value) => value.data()!['fcm']);
      return _token;
    } catch (e) {
      print('Error getting token: $e');
    }
    return null;
  }

  // send notification
  Future<void> sendNotification({
    required String userId,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      final _token = await getUserToken(userId);
      print('token is');
      print(_token);
      if (_token != null) {
        await sendHttppNotification(
          _token,
          title,
          body,
          data ??
              {
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'id': '1',
                'status': 'done',
              },
        );
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

// listen to notification
  Future<void> listenToNotification() async {
    try {
      await FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) {
        if (message != null) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 10,
              channelKey: 'basic_channel',
              title: message.notification!.title,
              body: message.notification!.body,
            ),
          );
        }
      });
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: message.notification!.title,
            body: message.notification!.body,
          ),
        );
        print('''
********** onMessage **********
${message.notification!.title}
${message.notification!.body}
${message.data}
********** onMessage **********




''');
        if (message.data['orderId'] != null) {
          NotificationsDB.instance.addNotification(
            notification: OrderNotification.fromRemoteMessage(message),
          );
        }
      });
    } catch (e) {
      print('Error listening to notification: $e');
    }
  }
}
