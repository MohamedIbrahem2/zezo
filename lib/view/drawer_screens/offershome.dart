// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:stockat/view/ofeers/offer2.dart';
// import 'package:stockat/view/ofeers/offer3.dart';

// import '../ofeers/offer1.dart';

// class OffersHome extends StatelessWidget {
//   const OffersHome({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.black),
//         title: const Text(
//           'Offers',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.blue.shade50,
//       ),
//       body: SingleChildScrollView(
//         child: SizedBox(
//           width: Get.width,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: Get.height * .02,
//               ),
//               Image.network(
//                 'https://cdn-icons-png.flaticon.com/512/3620/3620659.png',
//                 width: Get.width * .4,
//                 height: Get.height * .12,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 'Enjoy the best offers ! ',
//                 style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: Get.height * .1,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Get.to(Offer1(offerId: '1'));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.orange.shade200,
//                       boxShadow: const [
//                         BoxShadow(
//                             spreadRadius: 2, blurRadius: 5, color: Colors.grey)
//                       ]),
//                   margin: const EdgeInsets.only(bottom: 10),
//                   child: const Text(
//                     'First offer',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   width: Get.width * .6,
//                   height: Get.height * .08,
//                   alignment: Alignment.center,
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Get.to(const Offer2());
//                 },
//                 child: Container(
//                   decoration: const BoxDecoration(
//                       color: Colors.greenAccent,
//                       boxShadow: [
//                         BoxShadow(
//                             spreadRadius: 2, blurRadius: 5, color: Colors.grey)
//                       ]),
//                   margin: const EdgeInsets.only(bottom: 10),
//                   child: const Text(
//                     'Second offer',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   width: Get.width * .6,
//                   height: Get.height * .08,
//                   alignment: Alignment.center,
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Get.to(const Offer3());
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.blue.shade300,
//                       boxShadow: const [
//                         BoxShadow(
//                             spreadRadius: 2, blurRadius: 5, color: Colors.grey)
//                       ]),
//                   margin: const EdgeInsets.only(bottom: 10),
//                   child: const Text(
//                     'Third offer',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   width: Get.width * .6,
//                   height: Get.height * .08,
//                   alignment: Alignment.center,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/service/offer_service.dart';

import '../ofeers/offer1.dart';
import '../ofeers/offer2.dart';
import '../ofeers/offer3.dart';

class OffersHome extends StatelessWidget {
  const OffersHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Offers',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade50,
      ),
      body: StreamBuilder<List<Offer>>(
        stream: OfferService().getAllOffers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final offers = snapshot.data!;
            return SingleChildScrollView(
              child: SizedBox(
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/512/3620/3620659.png',
                      width: Get.width * .4,
                      height: Get.height * .12,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Enjoy the best offers!',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: Get.height * .1,
                    ),
                    Column(
                      children: offers.map((offer) {
                        return GestureDetector(
                          onTap: () {
                            if (offer.type == 'package') {
                              Get.to(Offer1(offerId: offer.id));
                            } else if (offer.type == 'discount') {
                              Get.to(Offer2(offer: offer));
                            } else {
                              Get.to(const Offer3());
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange.shade200,
                              boxShadow: const [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              offer.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            width: Get.width * .6,
                            height: Get.height * .08,
                            alignment: Alignment.center,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error loading offers',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
