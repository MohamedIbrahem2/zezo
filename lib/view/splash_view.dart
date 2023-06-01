import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/view/sign_in.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignIn())));
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
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'S',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple)),
                TextSpan(
                    text: 't',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
                TextSpan(
                    text: 'o',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
                TextSpan(
                    text: 'ck',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
                TextSpan(
                    text: 'A',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple)),
                TextSpan(
                    text: 'T',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple)),
              ])),
              SizedBox(
                height: Get.height * .05,
              ),
              Text(
                'By/ Eng Tareq',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'جميع الحقوق محفوظه',
                style: TextStyle(color: Colors.black),
              ),
            ],
          )),
    );
  }
}
