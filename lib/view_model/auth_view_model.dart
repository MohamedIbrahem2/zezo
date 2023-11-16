import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/main.dart';
import 'package:stockat/view/home_view.dart';

class AuthViewModel extends GetxController {
  bool isLoading = false;
  bool isPhotoLoading = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();
  late String email, password;
  String? name, phone;
  UserProfile? userProfile;
  Future<void> getUserProfile() async {
    userProfile = await _authService
        .getUserProfile(FirebaseAuth.instance.currentUser!.uid);
    if (userProfile!.isAdmin == true) {}
    update();
  }

// check if user is admin
  // Future<bool> checkIfAdmin() async {
  //   userProfile = await _authService
  //       .getUserProfile(FirebaseAuth.instance.currentUser!.uid);
  //   if (userProfile!.isAdmin == true) {}
  //   update();
  // }

  Future<void> uploadUserPhoto(String _imageFile) async {
    try {
      print('uploading');
      isPhotoLoading = true;
      update();
      await _authService.addPhoto(
          _imageFile, FirebaseAuth.instance.currentUser!.uid);
      print('uploaded');
      userProfile = await _authService
          .getUserProfile(FirebaseAuth.instance.currentUser!.uid);
      isPhotoLoading = false;
      update();
    } catch (e) {
      isPhotoLoading = false;
      update();
      Get.snackbar('Error', e.toString(),
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
    }
  }

  signUp() async {
    try {
      Get.snackbar(
        'Loading',
        'please wait',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );

      var data = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _authService.createUserProfile(
        userId: data.user!.uid,
        name: name!,
        phone: phone!,
      );

      userProfile = await _authService.getUserProfile(data.user!.uid);
      if (userProfile!.isAdmin == true) {
        // isAdmin = true;
      }
      Get.to(const HomeView());
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString(),
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
    }
    update();
  }

  updateProfile({
    String? name,
    String? phone,
    String? cr,
    String? vat,
  }) async {
    try {
      Get.snackbar(
        'Loading',
        'please wait',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
      await _authService.updateUserProfile(
        userId: FirebaseAuth.instance.currentUser!.uid,
        name: name!,
        phone: phone!,
      );

      userProfile = await _authService
          .getUserProfile(FirebaseAuth.instance.currentUser!.uid);

      Get.to(const HomeView());
    } catch (e, s) {
      print(e);
      print(s);
      Get.snackbar('Error', e.toString(),
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
    }
    update();
  }

  signIn() async {
    try {
      Get.snackbar('Loading', 'please wait',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.greenAccent);
      var data = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      userProfile = await _authService.getUserProfile(data.user!.uid);
      if (userProfile!.isAdmin == true || userProfile!.role == 'admin') {
        // isAdmin = true;
      }
      AdminProvider().checkIfAdmin();
      isLoading = false;
      Get.offAll(const HomeView());
      print(data);
    } catch (e) {
      isLoading = true;
      Get.snackbar('Error', e.toString(),
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
      isLoading = false;
    }
    update();
  }
}
