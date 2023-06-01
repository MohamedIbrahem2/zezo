import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/view/categories/drinks/coffe_tea.dart';
import 'package:stockat/view/categories/drinks/energy.dart';
import 'package:stockat/view/categories/drinks/juices.dart';
import 'package:stockat/view/categories/drinks/malt_drinks.dart';
import 'package:stockat/view/categories/drinks/milk.dart';
import 'package:stockat/view/categories/drinks/water.dart';

import 'soft_drinks.dart';

class DrinksHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Drinks',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade50,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * .04,
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
              height: Get.height * .03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(SoftDrinks());
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
                          'https://sagaciresearch.com/wp-content/uploads/2019/09/Top-10-Carbonated-Soft-Drinks-Egypt-V3.jpg',
                          fit: BoxFit.fill,
                        ),
                        width: Get.width * .4,
                        height: Get.height * .15,
                      ),
                      Text(
                        'Soft drinks',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(Water());
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
                          'https://5.imimg.com/data5/MU/JT/MY-1198768/mineral-water-bottle-500x500.jpg',
                          fit: BoxFit.fill,
                        ),
                        width: Get.width * .4,
                        height: Get.height * .15,
                      ),
                      Text(
                        'Water',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(Energy());
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
                          'https://www.bigbasket.com/media/uploads/p/l/13377_2-red-bull-energy-drink.jpg',
                          fit: BoxFit.fill,
                        ),
                        width: Get.width * .4,
                        height: Get.height * .15,
                      ),
                      Text(
                        'Energy drinks',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(Juices());
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
                          'https://stylesatlife.com/wp-content/uploads/2019/11/Best-Juices-for-Pregnancy-Along-with-Benefits-and-Recipes.jpg.webp',
                          fit: BoxFit.fill,
                        ),
                        width: Get.width * .4,
                        height: Get.height * .15,
                      ),
                      Text(
                        'Juices',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(Malt());
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
                          'https://cdn11.bigcommerce.com/s-58uvul1jf2/product_images/uploaded_images/allmalt.jpeg',
                          fit: BoxFit.fill,
                        ),
                        width: Get.width * .4,
                        height: Get.height * .15,
                      ),
                      Text(
                        'Malt drinks',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(CoffeTea());
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
                          'https://monsieurcoffee.com/wp-content/uploads/2021/07/is-coffee-technically-a-tea.jpg',
                          fit: BoxFit.fill,
                        ),
                        width: Get.width * .4,
                        height: Get.height * .15,
                      ),
                      Text(
                        'tea & coffe',
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
            GestureDetector(
              onTap: () {
                Get.to(Milk());
              },
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          spreadRadius: 2, blurRadius: 5, color: Colors.grey)
                    ]),
                    margin: EdgeInsets.only(bottom: 10),
                    child: Image.network(
                      'https://cdnprod.mafretailproxy.com/sys-master-root/h22/hd6/44240658333726/1700Wx1700H_77049_1.jpg',
                      fit: BoxFit.fill,
                    ),
                    width: Get.width * .4,
                    height: Get.height * .15,
                  ),
                  Text(
                    'Milk',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
