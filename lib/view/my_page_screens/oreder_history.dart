// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class OrderHistory extends StatelessWidget {
//   const OrderHistory({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue.shade100,
//         iconTheme: const IconThemeData(color: Colors.black),
//         title: const Text(
//           'Order history',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//       ),
//       body: SizedBox(
//           width: Get.width,
//           height: Get.height,
//           child: ListView.separated(
//               separatorBuilder: (context, inex) {
//                 return const Divider(
//                   thickness: 1,
//                   color: Colors.black,
//                   height: 40,
//                 );
//               },
//               itemCount: 10,
//               itemBuilder: (context, index) {
//                 return Column(
//                   children: [
//                     Container(
//                       child: const Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Invoice number',
//                             style: TextStyle(
//                                 fontSize: 19,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black),
//                           ),
//                           Divider(
//                             color: Colors.grey,
//                           ),
//                           Text(
//                             '1',
//                             style: TextStyle(
//                                 fontSize: 19,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black),
//                           ),
//                         ],
//                       ),
//                       margin: const EdgeInsets.all(3),
//                       width: Get.width * .45,
//                       height: Get.height * .1,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: Colors.greenAccent,
//                           boxShadow: const [
//                             BoxShadow(
//                                 blurRadius: 2,
//                                 spreadRadius: 1,
//                                 color: Colors.black)
//                           ]),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Container(
//                           child: const Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'order date',
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black),
//                               ),
//                               Divider(
//                                 color: Colors.grey,
//                               ),
//                               Text(
//                                 '10-2-2024',
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black),
//                               ),
//                             ],
//                           ),
//                           margin: const EdgeInsets.all(3),
//                           width: Get.width * .4,
//                           height: Get.height * .1,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Colors.greenAccent.shade100,
//                               boxShadow: const [
//                                 BoxShadow(
//                                     blurRadius: 2,
//                                     spreadRadius: 1,
//                                     color: Colors.black)
//                               ]),
//                         ),
//                         Container(
//                           child: const Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'total amount',
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black),
//                               ),
//                               Divider(
//                                 color: Colors.grey,
//                               ),
//                               Text(
//                                 '1400 SR',
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black),
//                               ),
//                             ],
//                           ),
//                           margin: const EdgeInsets.all(3),
//                           width: Get.width * .4,
//                           height: Get.height * .1,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Colors.greenAccent.shade100,
//                               boxShadow: const [
//                                 BoxShadow(
//                                     blurRadius: 2,
//                                     spreadRadius: 1,
//                                     color: Colors.black)
//                               ]),
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               })),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/service/order_service.dart';

class OrderHistory extends StatelessWidget {
  final OrderService orderService = OrderService();

  OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime date) =>
        '${date.day}/${date.month}/${date.year}';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Order history',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Order>>(
        stream: orderService.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final orders = snapshot.data!;
            return ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 1,
                  color: Colors.black,
                  height: 40,
                );
              },
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Column(
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Invoice number',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          Text(
                            order.orderDate.microsecondsSinceEpoch
                                .toString(), // Display the invoice number from the order
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(3),
                      width: Get.width * .45,
                      height: Get.height * .1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.greenAccent,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 1,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Order date',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Text(
                                formatDate(order
                                    .orderDate), // Display the order date from the order

                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.all(3),
                          width: Get.width * .4,
                          height: Get.height * .1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.greenAccent.shade100,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 1,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Total amount',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Text(
                                '${order.totalAmount} SR', // Display the total amount from the order
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.all(3),
                          width: Get.width * .4,
                          height: Get.height * .1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.greenAccent.shade100,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 1,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
