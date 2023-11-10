import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/view/sign_in.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const SignIn())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('logos/splash.png'),
              Image.asset('images/logo2.png'),
              SizedBox(
                height: Get.height * .05,
              ),
              const Text(
                'By/ Eng Tareq',
                style: TextStyle(color: Colors.black),
              ),
              const Text(
                'جميع الحقوق محفوظه',
                style: TextStyle(color: Colors.black),
              ),
            ],
          )),
    );
  }
}
