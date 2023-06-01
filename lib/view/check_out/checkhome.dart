import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'add_address.dart';

class CheckHome extends StatefulWidget {
  @override
  State<CheckHome> createState() => _CheckHomeState();
}

class _CheckHomeState extends State<CheckHome> {
  DateTime now = DateTime.now();
  String finalDate = '';

  getCurrentDate() {
    var date = new DateTime.now().add(Duration(days: 1)).toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}/${dateParse.month}/${dateParse.year}";

    setState(() {
      finalDate = formattedDate.toString();
    });
  }

  List days = [
    'Saturday',
    'Sunday',
    'Monday',
    'tuesday',
    'wednesday',
    'thursday',
  ];
  List date = [
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
  ];

  double count = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Check Out',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 2,
                              blurRadius: 5,
                            )
                          ]),
                      child: Image.network(
                          'https://preview.redd.it/oops-bobs-bebsi-v0-u4b0g8lw5uc91.jpg?width=640&crop=smart&auto=webp&s=e2f1dedbb8dd0c574487e9b8c8e1b007e86927c3'),
                      margin: EdgeInsets.only(right: 7),
                      width: Get.width * .27,
                      height: Get.height * .12,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Product name',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          '25.50 SR',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        Container(
                          width: Get.width * .25,
                          height: 30,
                          color: Colors.grey.shade300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: Icon(Icons.add),
                                onTap: () {
                                  setState(() {
                                    count++;
                                  });
                                },
                              ),
                              Text('$count'),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      count--;
                                    });
                                  },
                                  child: Icon(Icons.remove_outlined))
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                width: Get.width * .95,
                height: Get.height * .2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 5,
                      )
                    ]),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, top: 30),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Deliver to',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 3,
                        )
                      ]),
                  width: Get.width * .87,
                  height: 45,
                  child: Text(
                    'Add Adress',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  alignment: Alignment.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, top: 30),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Delivery Date',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Container(
                width: Get.width,
                height: Get.height * .15,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              days[index],
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '10-12-2023',
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        margin: EdgeInsets.all(15),
                        width: Get.width * .4,
                        height: Get.height * .11,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: .4,
                                  blurRadius: 2,
                                  color: Colors.black),
                            ],
                            borderRadius: BorderRadius.circular(5)),
                      );
                    }),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, top: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'View available coupon',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    width: Get.width * .6,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Enter Coupon code',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent),
                        child: Text('Apply')),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'items',
                          style: TextStyle(
                              fontSize: 18, color: Colors.grey.shade800),
                        ),
                        Text(
                          '10 pieces',
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                              fontSize: 18, color: Colors.grey.shade800),
                        ),
                        Text(
                          '200 SR',
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Vat 15%',
                          style: TextStyle(
                              fontSize: 18, color: Colors.grey.shade800),
                        ),
                        Text(
                          '30 SR',
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'discount',
                          style: TextStyle(
                              fontSize: 18, color: Colors.grey.shade800),
                        ),
                        Text(
                          '0 SR',
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'delivery',
                          style: TextStyle(
                              fontSize: 18, color: Colors.grey.shade800),
                        ),
                        Text(
                          '0 SR',
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total with vat',
                          style: TextStyle(
                              fontSize: 18, color: Colors.grey.shade800),
                        ),
                        Text(
                          '230 SR',
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ],
                ),
                margin: EdgeInsets.all(15),
                width: Get.width * .9,
                height: Get.height * .25,
                decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: .4, blurRadius: 2, color: Colors.black),
                    ],
                    borderRadius: BorderRadius.circular(5)),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (context) => GestureDetector(
          onTap: () {
            Get.defaultDialog(
                title: 'Are you sure to place order?',
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 10, primary: Colors.greenAccent),
                        onPressed: () {},
                        child: Text(
                          'yes',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 10, primary: Colors.white),
                        onPressed: () {},
                        child: Text(
                          'cancle',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ));
          },
          child: Container(
            alignment: Alignment.center,
            width: Get.width,
            height: 50,
            color: Colors.greenAccent,
            child: Text(
              'Checkout',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
