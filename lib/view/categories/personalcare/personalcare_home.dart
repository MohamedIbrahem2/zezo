import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/view/categories/personalcare/baby.dart';
import 'package:stockat/view/categories/personalcare/detergent.dart';
import 'package:stockat/view/categories/personalcare/women.dart';

import 'men.dart';

class PersonalCareHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
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
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 30,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 1),
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
                    Get.to(Detergent());
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ]),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Image.network(
                          'https://www.conserve-energy-future.com/wp-content/uploads/2021/06/detergent-bottles.jpg',
                          fit: BoxFit.fill,
                        ),
                        width: Get.width * .4,
                        height: Get.height * .15,
                      ),
                      Text(
                        'detergents',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(Women());
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ]),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Image.network(
                          'https://esajee.com/media/catalog/product/cache/f6c2c76ea2dfd05ab28cc96edfc1214c/4/0/4015400646860.jpg',
                          fit: BoxFit.fill,
                        ),
                        width: Get.width * .4,
                        height: Get.height * .15,
                      ),
                      Text(
                        'Women',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(Men());
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ]),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQt_-YVConYCIAn4EHxghgfDr-vBrv6PbdjTiRu-Sz6_RzIkjQ4rPsQEKl5TaE1ptV8-Bs&usqp=CAU',
                          fit: BoxFit.fill,
                        ),
                        width: Get.width * .4,
                        height: Get.height * .15,
                      ),
                      Text(
                        'men',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(Baby());
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ]),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYe1inwdWVBOf2g58cYlcXovQHb3WrUM1SLs61qrqW0ie9UbkFDQdnIgEVUAMSVz3qFXc&usqp=CAU',
                          fit: BoxFit.fill,
                        ),
                        width: Get.width * .4,
                        height: Get.height * .15,
                      ),
                      Text(
                        'babys',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
