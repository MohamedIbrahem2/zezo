import 'dart:async';

import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:get/get.dart';
import 'package:stockat/view/home_view.dart';
import 'package:stockat/view/onbording_view.dart';
import 'package:stockat/view/sign_in.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
late bool first;
firstTime()async {
  bool firstRun = await IsFirstRun.isFirstRun();
  first = firstRun;
}


class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    firstTime();
    Timer(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>  first ? const OnBording() : const HomeView())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            width: Get.width*.4,
          color: Colors.white,
          child: Center(child: Image.asset('images/MYD logo2.png'))),
    );
  }
}
