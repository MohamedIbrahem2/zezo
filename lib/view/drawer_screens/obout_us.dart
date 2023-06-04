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
          child: Column(
            children: [
              const Text(
                'We are a commercial multi-supply corporation, specialized in distributing drinks, foodstuffs, and everything related to our valued customers. It was established in 2013 and is headquartered in the city (Al-Khobar). We work hard to provide high quality products to our customers in the widest range, lowest prices and best service.We are distinguished by the testimony of all our customers by our strong commitment to providing the best service.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'We provide a wide range of products, including soft drinks, natural juices, mineral water, canned and frozen foodstuffs, sweets, chocolates, and many more. We take great care to meet customer needs and provide excellent customer service.We are distinguished by a distinguished and qualified work team, and we strongly believe in providing a conducive and supportive work environment for employees. We aim to provide opportunities for professional and personal development to all employees, and we are keen to provide rewards and incentives that reflect outstanding performance.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'We work hard to achieve our vision of providing high quality products to our customers, and we always strive for continuous improvement and innovation in the field of beverages and food. We are always proud of our valued customers and look forward to continued growth and expansion in the future.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: Get.width,
                  height: Get.height * .35,
                  child: Image.asset(
                    'images/e9137044-e968-465b-9e9d-2a25d7b94c58.jpg',
                    fit: BoxFit.fill,
                  )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: Get.width,
                  height: Get.height * .4,
                  child: Image.asset(
                    'images/80a399cd-77b2-4493-936a-1392b40a9a94.jpg',
                    fit: BoxFit.fill,
                  )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: Get.width,
                  height: Get.height * .4,
                  child: Image.asset(
                    'images/a3962d45-46ec-4737-b978-1149982fae1b.jpg',
                    fit: BoxFit.fill,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
