import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Offer1 extends StatelessWidget {
  List colors = [
    Colors.red.shade50,
    Colors.teal.shade50,
    Colors.orangeAccent.shade100,
    Colors.blue.shade50,
    Colors.grey.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        title: Text(
          'Offer',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * .01,
              ),
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/3620/3620659.png',
                width: Get.width * .25,
                height: Get.height * .08,
              ),
              SizedBox(
                height: Get.height * .01,
              ),
              Text(
                'Enjoy the best discount ! ',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: Get.height * .01,
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: Get.width,
                height: Get.height * .705,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          (Container(
                            padding: EdgeInsets.all(12),
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        width: Get.width * .18,
                                        height: Get.height * .1,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 4,
                                                  spreadRadius: 1,
                                                  color: Colors.grey)
                                            ]),
                                        child: Image.network(
                                          'https://m.media-amazon.com/images/I/61ZpNfQMDOL.jpg',
                                        ),
                                      ),
                                      Text(
                                        'product1',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Container(
                                      alignment: Alignment.center,
                                      child: Text('+',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)));
                                },
                                itemCount: 10),
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            width: Get.width * .9,
                            height: Get.height * .22,
                            decoration: BoxDecoration(
                                color: colors[index],
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                      color: Colors.grey)
                                ]),
                          )),
                          Positioned(
                            child: Text(
                              '250 SR',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                            top: 5,
                          ),
                          Positioned(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Text(
                                    'Get',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.white,
                                  )
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                            ),
                            bottom: 0,
                          ),
                          Positioned(
                            bottom: 10,
                            right: 15,
                            child: Column(
                              children: [
                                Icon(Icons.arrow_forward_outlined),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                    separatorBuilder: (conext, index) {
                      return Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(
                            'OR',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ));
                    },
                    itemCount: 5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
