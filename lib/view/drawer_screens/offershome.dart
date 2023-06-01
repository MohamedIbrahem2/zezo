import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/view/categories/blastic/paper.dart';
import 'package:stockat/view/ofeers/offer2.dart';
import 'package:stockat/view/ofeers/offer3.dart';

import '../ofeers/offer1.dart';

class OffersHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Offers',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade50,
      ),
      body: SingleChildScrollView(
        child: Container(
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
              SizedBox(
                height: 20,
              ),
              Text(
                'Enjoy the best offers ! ',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: Get.height * .1,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(Offer1());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.orange.shade200,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2, blurRadius: 5, color: Colors.grey)
                      ]),
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'First offer',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  width: Get.width * .6,
                  height: Get.height * .08,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(Offer2());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2, blurRadius: 5, color: Colors.grey)
                      ]),
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Second offer',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  width: Get.width * .6,
                  height: Get.height * .08,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(Offer3());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2, blurRadius: 5, color: Colors.grey)
                      ]),
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Third offer',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  width: Get.width * .6,
                  height: Get.height * .08,
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
