import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int points = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Your wallet',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            Image.asset(
              'images/trophy.png',
              width: Get.width * .35,
              height: 130,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 80,
                child: Text(
                  '$points',
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              width: Get.width * .7,
              height: Get.height * .2,
              color: mainColor,
            ),
            const Text(
              'Your points now',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Your gift is: ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
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
                style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor),
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
                              const Text(
                                'You get your gift',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                          backgroundColor: mainColor);
                    } else {
                      Get.defaultDialog(
                          title: '',
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
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
                          backgroundColor:mainColor);
                    }
                  });
                },
                child: const Text(
                  'Get your gift',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
