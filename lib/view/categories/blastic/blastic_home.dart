import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/view/categories/blastic/paper.dart';

import 'blastic.dart';

class BlasticBaber extends StatelessWidget {
  const BlasticBaber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Blastic & Paper',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade50,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
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
                height: Get.height * .1,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const Blastic());
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
                        'https://images.thdstatic.com/productImages/3505e057-d617-43d2-a1f9-02b4d679389f/svn/colorful-costway-utility-carts-hw53825-64_1000.jpg',
                        fit: BoxFit.fill,
                      ),
                      width: Get.width * .6,
                      height: Get.height * .19,
                    ),
                    const Text(
                      'Blastic',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const Paper());
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
                        'https://m.media-amazon.com/images/I/61c2nZwYlDL._AC_UF1000,1000_QL80_.jpg',
                        fit: BoxFit.fill,
                      ),
                      width: Get.width * .6,
                      height: Get.height * .19,
                    ),
                    const Text(
                      'Paper',
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
