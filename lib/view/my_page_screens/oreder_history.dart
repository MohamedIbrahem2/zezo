import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stockat/constants.dart';
import 'package:stockat/main.dart';
import 'package:stockat/service/order_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../service/address_service.dart';
import 'oreders_provider.dart';

String formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});
  static _OrderHistoryState of(BuildContext context) =>
      context.findAncestorStateOfType<_OrderHistoryState>()!;
  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {
    context.read<OrdersHistoryProvider>().fetchOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime date) =>
        '${date.day}/${date.month}/${date.year}';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Order history',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const StatusTaps(),
    );
  }
}

class AddressItem extends StatelessWidget {
  const AddressItem({Key? key, required this.address}) : super(key: key);

  final Address address;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(address.street),
      subtitle: Text('${address.city}, ${address.state} ${address.postalCode}'),
      trailing: IconButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderMap(
                        address: address,
                      )));
        },
        icon: const Icon(Icons.map),
      ),
      // You can customize the rest of the UI for the address item as needed
      // For example, you might want to show the description or location on a map.
    );
  }
}

class OrderMap extends StatelessWidget {
  const OrderMap({Key? key, required this.address}) : super(key: key);
  final Address address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(address.street),
      ),
      body: Stack(
        children: [
          GoogleMap(
            markers: {
              Marker(
                  markerId: MarkerId(address.id!),
                  position: LatLng(address.latitude, address.longitude))
            },
            initialCameraPosition: CameraPosition(
                target: LatLng(address.latitude, address.longitude), zoom: 15),
          ),

          // button to open google map app
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: ElevatedButton(
              onPressed: () {
                final url =
                    'https://www.google.com/maps/dir/?api=1&destination=${address.latitude},${address.longitude}';
                launchUrl(Uri.parse(url));
              },
              child: const Text('follow the delivery on google map'),
            ),
          )
        ],
      ),
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
    final orderHistory = context.watch<OrdersHistoryProvider>();
    return Column(
      children: [
        SizedBox(height:20,),
        SizedBox(
            height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (var status in orderHistory.statuses)
                    InkWell(
                      onTap: () {
                        orderHistory.status = (status);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color:
                                context.watch<OrdersHistoryProvider>().status ==
                                        status
                                    ? mainColor
                                    : Colors.pink.shade200,
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  color: Colors.black)
                            ]),
                        child: Text(status,style: TextStyle(
                          color: Colors.white
                        ),),
                      ),
                    ),
                ],
              ),
            )),
        Expanded(
          child: orderHistory.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : orderHistory.orders
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
                      itemCount: orderHistory.orders
                          .where((element) => element.address != null)
                          .length,
                      itemBuilder: (context, index) {
                        final order = orderHistory.orders
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

          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              Text('Address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          // user info

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
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('User Info',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              IconButton(
                  onPressed: () {
                    final auth = AuthService();
                    showDialog(
                        context: context,
                        builder: (c) => Dialog(
                              child: SizedBox(
                                width: Get.width,
                                height: 200,
                                child: FutureBuilder<UserProfile>(
                                    future: auth.getUserProfile(order.userId),
                                    builder: (context, snapHot) {
                                      if (snapHot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      final userProfile = snapHot.data;
                                      return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // ListTile(
                                            //   title: const Text('User Name'),
                                            //   trailing: Text(userProfile!.name),
                                            // ),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  userProfile!.name,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.pink,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                              children: [
                                                const Text(
                                                  'User Phone',
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      userProfile.phone,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),

                                                  ],
                                                )
                                              ],
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  launchUrl(Uri.parse(
                                                      'tel:${userProfile.phone}'));
                                                },
                                                icon: const Icon(
                                                  Icons.phone,
                                                  color: Colors.blue,
                                                  size: 30,
                                                )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                              children: [
                                                const Text(
                                                  'User Email',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      userProfile.email ?? '',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),

                                                  ],
                                                ),

                                              ],
                                            ),

                                            IconButton(
                                                onPressed: () {
                                                  launchUrl(Uri.parse(
                                                      'mailto:${userProfile.email}'));
                                                },
                                                icon: const Icon(
                                                  Icons.email,
                                                  color: Colors.blue,
                                                  size: 30,
                                                )),
                                            // ListTile(
                                            //   title: const Text('User Email'),
                                            //   trailing:
                                            //       Text(userProfile.email ?? ''),
                                            // ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ));
                  },
                  icon: const Icon(
                    Icons.info,
                    color: Colors.blue,
                  ))
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
        ],
      ),
    );
  }
}
