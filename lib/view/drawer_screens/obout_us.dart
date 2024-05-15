import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'About us',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          width: Get.width,
          height: Get.height * 2.2,
          child: const Column(
            children: [
              Text(
                'Dear customer Zezo application Experience in the field of beverages, food , Detergents, and more',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Zezo application gives you the opportunity to choose from available products at the best prices. We work to provide the best service, faster delivery, high-quality products, on-time delivery, unbeatable prices, better communication service, and faster response.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'All this and more for you, our dear customer We spare no effort in providing you with the best service and always strive for your satisfaction. We provide all possible ways to do so.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(

                'We have a fleet of cars that will reach you as quickly as possible We have delivery agents and representatives who serve you in delivering the goods as quickly as possible and arranging them in the place you want We can say that our main concern is serving you and we always strive to satisfy you',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Browse our products and you will see for yourself how we have provided you with everything you are looking for at the best possible prices',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Greetings from zezo application management',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
