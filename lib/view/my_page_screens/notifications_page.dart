import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:stockat/view/my_page_screens/oreder_history.dart';
import 'package:stockat/view/my_page_screens/theme.dart';

import '../../notifications_db.dart';
import '../../service/order_service.dart';
// Import your notifications service

class NotificationsPage extends StatefulWidget {
  final String userId; // Pass the user's ID to fetch their notifications

  const NotificationsPage({super.key, required this.userId});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<List<BaseNotification>>(
        stream: NotificationsDB.instance.getUserNotifications(widget.userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No notifications.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final notification = snapshot.data![index];
                return NotificationItem(
                    notification: notification as OrderNotification);
              },
            );
          }
        },
      ),
    );
  }
}

String formatNotificationDate(DateTime time) {
  // format like form 1 hour ago or 1 day ago
  final now = DateTime.now();
  final diff = now.difference(time);
  if (diff.inDays > 0) {
    return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
  } else if (diff.inHours > 0) {
    return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
  } else if (diff.inMinutes > 0) {
    return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
  } else {
    return 'Just now';
  }
}

class NotificationItem extends StatelessWidget {
  final OrderNotification notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final isRead = notification.isRead;
    final status = notification.orderStatus;
    final time = notification.time;

    // Define the background color and border color based on whether the notification is read or unread.
    final bgColor = isRead ? Colors.grey[200] : Colors.white;
    final borderColor =
        isRead ? Colors.grey : Colors.blue; // Customize border color as needed.

    return LayoutBuilder(
      builder: (c, s) {
        return Container(
          height: 90,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: DecoratedBox(
            decoration: BoxDecoration(
              // shadow
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
              color: isRead ? Colors.grey[200] : Colors.white,
              borderRadius: BorderRadius.circular(10),
              // border:
              //     Border.all(width: .8, color: Theme.of(context).primaryColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(
                    getIconData(
                      status,
                    ),
                    color: Colors.blue,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          notification.title, //  'Call Request',
                          style: textStyleWithPrimarySemiBold.copyWith(
                            fontSize: 16,
                            height: 1,
                            color: kPrimaryColor,
                          ),
                        ),
                        // if (widget.request.notificationDate != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              formatDate(notification.time), //  'Call Request',
                              style: textStyleWithPrimarySemiBold.copyWith(
                                fontSize: 14,
                                color: const Color(0xff5D6C7A),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              DateFormat(
                                'EEEE, d MMM, yyyy',
                                (Get.locale == 'ar') ? 'ar' : 'en',
                              ).format(
                                notification.time,
                              ),
                              style: textStyleWithPrimarySemiBold.copyWith(
                                fontSize: 14,
                                color: const Color(0xff5D6C7A),
                              ),
                            ),
                          ],
                        ),
                        // if (widget.request.washNumber != null)
                        Text(
                          notification.body, //   'Friday',
                          style: textStyleWithPrimarySemiBold.copyWith(
                            fontSize: 14,
                          ),
                        )
                        // else
                        //   Text(
                        //     'Reuest from package ${widget.package!.name}', //   'Friday',
                        //     style: textStyleWithPrimarySemiBold.copyWith(
                        //       fontSize: 14,
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// get icon data for notification status
IconData getIconData(String status) {
  switch (status) {
    case OrderStatusKeys.pending:
      return FontAwesomeIcons.clock;
    case OrderStatusKeys.processing:
      return FontAwesomeIcons.cog;
    case OrderStatusKeys.shipped:
      return FontAwesomeIcons.truck;
    case OrderStatusKeys.delivered:
      return FontAwesomeIcons.check;
    case OrderStatusKeys.cancelled:
      return FontAwesomeIcons.times;
    default:
      return (Icons.notifications);
  }
}
