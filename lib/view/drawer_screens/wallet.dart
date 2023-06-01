import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wallet extends StatefulWidget {
  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int points = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Your wallet',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Image.asset(
              'images/trophy.png',
              width: Get.width * .35,
              height: 130,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 80,
                child: Text(
                  '$points',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              width: Get.width * .7,
              height: Get.height * .2,
              color: Colors.greenAccent,
            ),
            Text(
              'Your points now',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Your gift is: ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Reach to 1000 points \n      to get your gift',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                Image.asset(
                  'images/inlove.png',
                  width: 25,
                  height: 25,
                )
              ],
            ),
            SizedBox(
              height: Get.height * .05,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.greenAccent),
                onPressed: () {
                  setState(() {
                    if (points >= 1000) {
                      Get.defaultDialog(
                          title: 'Congratulation',
                          content: Column(
                            children: [
                              Image.asset(
                                'images/trophy.png',
                                width: Get.width * .30,
                                height: 30,
                              ),
                              Text(
                                'You get your gift',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                          backgroundColor: Colors.greenAccent);
                    } else {
                      Get.defaultDialog(
                          title: '',
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Reach to 1000 points \n      to get your gift',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Image.asset(
                                'images/sad.png',
                                width: 25,
                                height: 25,
                              )
                            ],
                          ),
                          backgroundColor: Colors.greenAccent);
                    }
                  });
                },
                child: Text(
                  'Get your gift',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
