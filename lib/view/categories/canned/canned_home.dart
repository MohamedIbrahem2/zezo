import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/view/categories/canned/canned.dart';
import 'package:stockat/view/categories/canned/sause.dart';

class CannedHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Canned & Sauce',
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
                height: Get.height * .1,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(Canned());
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
                        'https://cdn.hswstatic.com/gif/canned-food.jpg',
                        fit: BoxFit.fill,
                      ),
                      width: Get.width * .6,
                      height: Get.height * .19,
                    ),
                    Text(
                      'Canned',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(Sauce());
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
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnnINQBuiwRVFUSiUYQUPihFbFmWv8E2oA_kO-HKOz0Mye_wBEaPW3OkPWJx82DOSHxYc&usqp=CAU',
                        fit: BoxFit.fill,
                      ),
                      width: Get.width * .6,
                      height: Get.height * .19,
                    ),
                    Text(
                      'Sauce',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
