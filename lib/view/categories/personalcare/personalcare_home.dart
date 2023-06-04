import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/view/categories/personalcare/baby.dart';
import 'package:stockat/view/categories/personalcare/detergent.dart';
import 'package:stockat/view/categories/personalcare/women.dart';

import 'men.dart';

class PersonalCareHome extends StatelessWidget {
  const PersonalCareHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'detergents & personal care',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade50,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * .06,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 30,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 1),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * .12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(const Detergent());
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ]),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Image.network(
                          'https://www.conserve-energy-future.com/wp-content/uploads/2021/06/detergent-bottles.jpg',
                          fit: BoxFit.fill,
                        ),
                        width: Get.width * .4,
                        height: Get.height * .15,
                      ),
                      const Text(
                        'detergents',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const Women());
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ]),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Image.network(
                          'https://esajee.com/media/catalog/product/cache/f6c2c76ea2dfd05ab28cc96edfc1214c/4/0/4015400646860.jpg',
                          fit: BoxFit.fill,
                        ),
                        width: Get.width * .4,
                        height: Get.height * .15,
                      ),
                      const Text(
                        'Women',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(const Men());
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ]),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQt_-YVConYCIAn4EHxghgfDr-vBrv6PbdjTiRu-Sz6_RzIkjQ4rPsQEKl5TaE1ptV8-Bs&usqp=CAU',
                          fit: BoxFit.fill,
                        ),
                        width: Get.width * .4,
                        height: Get.height * .15,
                      ),
                      const Text(
                        'men',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const Baby());
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ]),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYe1inwdWVBOf2g58cYlcXovQHb3WrUM1SLs61qrqW0ie9UbkFDQdnIgEVUAMSVz3qFXc&usqp=CAU',
                          fit: BoxFit.fill,
                        ),
                        width: Get.width * .4,
                        height: Get.height * .15,
                      ),
                      const Text(
                        'babys',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
