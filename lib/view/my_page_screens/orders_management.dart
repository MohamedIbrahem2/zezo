import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stockat/main.dart';
import 'package:stockat/service/order_service.dart';
import 'package:stockat/view/my_page_screens/orders_management_provider.dart';

import 'oreder_history.dart';

String formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';

class OrdersManagement extends StatefulWidget {
  const OrdersManagement({super.key});
  static _OrdersManagementState of(BuildContext context) =>
      context.findAncestorStateOfType<_OrdersManagementState>()!;
  @override
  State<OrdersManagement> createState() => _OrdersManagementState();
}

class _OrdersManagementState extends State<OrdersManagement> {
  @override
  void initState() {
    context.read<OrdersManagementProvider>().fetchOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime date) =>
        '${date.day}/${date.month}/${date.year}';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'orders Management'.tr,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: const StatusTaps(),
    );
  }
}

class DottedLine extends StatelessWidget {
  const DottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    double dotWidth = 7;
    // get the parent width
    Widget buildDot() {
      return Container(
        width: dotWidth,
        height: 1,
        color: Colors.black,
      );
    }

    double space = 10.0;

    return LayoutBuilder(builder: (context, constraints) {
      double parentWidth = constraints.maxWidth;
      int dottesCount = parentWidth ~/ (dotWidth + space);
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i in List.generate(dottesCount, (index) => buildDot()))
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                i,
                SizedBox(
                  width: space,
                )
              ],
            ),
        ],
      );
    });
  }
}

// status taps
class StatusTaps extends StatefulWidget {
  const StatusTaps({super.key});

  @override
  State<StatusTaps> createState() => _StatusTapsState();
}

class _StatusTapsState extends State<StatusTaps> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final OrdersManagement = context.watch<OrdersManagementProvider>();
    return Column(
      children: [
        SizedBox(
            height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (var status in OrdersManagement.statuses)
                    InkWell(
                      onTap: () {
                        OrdersManagement.status = (status);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: context
                                        .watch<OrdersManagementProvider>()
                                        .status ==
                                    status
                                ? Colors.blue.shade100
                                : Colors.greenAccent.shade100,
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  color: Colors.black)
                            ]),
                        child: Text(status),
                      ),
                    ),
                ],
              ),
            )),
        Expanded(
          child: OrdersManagement.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : OrdersManagement.orders
                      .where((element) => element.address != null)
                      .isEmpty
                  ? Center(
                      child: Text('No Orders Yet'.tr),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 20,
                          color: Colors.grey.shade300,
                        );
                      },
                      itemCount: OrdersManagement.orders
                          .where((element) => element.address != null)
                          .length,
                      itemBuilder: (context, index) {
                        final order = OrdersManagement.orders
                            .where((element) => element.address != null)
                            .toList()[index];
                        // UserProfile? userProfile;
                        // if (userSnapHot.data != null) {
                        //   userProfile = userSnapHot.data!
                        //       .where((element) => element.id == order.userId)
                        //       .first;
                        // }

                        return OrderItem(order: order);
                      },
                    ),
        ),
      ],
    );
  }
}

class OrderItem extends StatefulWidget {
  const OrderItem({super.key, required this.order});
  final Order order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  late Order order;
  @override
  void initState() {
    order = widget.order;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int totalQuantity = 0;

    double totalPrice = 0;
    double discount = 0;

    // Calculate total quantity and price
    for (var item in order.items) {
      totalQuantity += item.quantity;
      totalPrice += item.price * item.quantity;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ...widget.order.items
              .where((element) => element.image.isNotEmpty)
              .map((cartItem) => ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: cartItem.image,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    title: Text(cartItem.productName),
                    subtitle: Text('${cartItem.price} SAR'),
                    trailing: CircleAvatar(
                        radius: 15, child: Text(cartItem.quantity.toString())),
                  )),
          if (order.userProfile != null)
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.greenAccent.shade100,
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 2, spreadRadius: 1, color: Colors.black)
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Customer Name: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(order.userProfile!.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400)),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Customer Email: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(order.userProfile!.email ?? '',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400)),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Customer Phone: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(order.userProfile!.phone ?? '',
                          style: const TextStyle(
                              fontSize: 16 , fontWeight: FontWeight.w400)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Other Phones: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      order.phones != null
                          ? order.phones!.isEmpty
                              ? const Text('Not Provided')
                              : Column(
                                  children: order.phones!
                                      .map((e) => Text(e))
                                      .toList(),
                                )
                          : const Text('Not Provided'),
                    ],
                  ),
                ],
              ),
            ),

          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              Text('Address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),

          AddressItem(
            address: widget.order.address!,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Dilivery Date',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.greenAccent.shade100,
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 2, spreadRadius: 1, color: Colors.black)
                    ]),
                child: Text(formatDate(widget.order.deliveryDate),
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Status',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.greenAccent.shade100,
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 2, spreadRadius: 1, color: Colors.black)
                    ]),
                child: Text(widget.order.status!,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400)),
              ),
            ],
          ),

          // user photo
          // Row(
          //   children: [
          //     CircleAvatar(
          //       radius: 20,
          //       child:
          //           (userProfile == null || userProfile.photo != null)
          //               ? Text(userProfile!.name.substring(0, 1))
          //               : null,
          //       backgroundImage: userProfile.photo != null
          //           ? NetworkImage(userProfile.photo!)
          //           : null,
          //     ),

          //     // user name
          //     Text(userProfile.name),
          //   ],
          // ),
          ListTile(
            title: const Text('Total Quantity'),
            trailing: Text(totalQuantity.toString()),
          ),
          // doted line
          const DottedLine(),

          ListTile(
            title: const Text('Total Price'),
            trailing: Text(totalPrice.toString()),
          ),
          ListTile(
            title: const Text('Discount'),
            trailing: Text(discount.toString()),
          ),
          ListTile(
            title: const Text('Total'),
            trailing: Text((totalPrice - discount).toStringAsFixed(2)),
          ),
          ListTile(
            title: const Text('Order Date'),
            trailing: Text(formatDate(widget.order.orderDate)),
          ),
          if (widget.order.invoiceNumber != null)
            ListTile(
              title: const Text('Invoice Number'),
              trailing: Text(widget.order.invoiceNumber!),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (context.watch<OrdersManagementProvider>().status !=
                  'delivered')
                ElevatedButton(
                    onPressed: () async {
                      context
                          .read<OrdersManagementProvider>()
                          .updateOrderStatusAction(order.id, order.userId);
                    },
                    child: Text(context
                        .watch<OrdersManagementProvider>()
                        .getActionText(order.status!))),
              if (!context.watch<AdminProvider>().isAdmin &&
                  order.status == 'pending')
                ElevatedButton(
                    onPressed: () async {
                      context
                          .read<OrdersManagementProvider>()
                          .updateOrderStatusAction(order.id, order.userId);
                    },
                    child: Text(context
                        .watch<OrdersManagementProvider>()
                        .getActionText(order.status!))),
              if (order.status == 'pending' || order.status == 'processing')
                const SizedBox(
                  width: 10,
                ),
              if (order.status == 'pending' || order.status == 'processing')
                ElevatedButton(
                    onPressed: () async {
                      context
                          .read<OrdersManagementProvider>()
                          .cancelOrder(order.id);
                    },
                    child: const Text('Cancel Order'))
            ],
          ),
        ],
      ),
    );
  }
}
