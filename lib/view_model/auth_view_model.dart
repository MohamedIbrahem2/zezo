import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/bottom_nav/screen1.dart';

class AuthViewModel extends GetxController {
  bool isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  late String email, password;
  String? name, phone, cr, vat;

  signUp() async {
    try {
      Get.snackbar(
        'Loading',
        'please wait',
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
      var data = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.to(Screen1());
      print(data);
    } catch (e) {
      Get.snackbar('Error', '${e.toString()}',
          duration: Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
    }
    update();
  }

  signIn() async {
    try {
      Get.snackbar('Loading', 'please wait',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.greenAccent);
      var data = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      isLoading = false;
      Get.to(Screen1());
      print(data);
    } catch (e) {
      isLoading = true;
      Get.snackbar('Error', '${e.toString()}',
          duration: Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
      isLoading = false;
    }
    update();
  }
}
