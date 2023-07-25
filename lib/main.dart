// @dart=2.16
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/view/home_view.dart';

import 'view/splash_view.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  var user = FirebaseAuth.instance.currentUser;

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: user == null ? const MyHomePage() : const HomeView(),
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserProfile({
    required String userId,
    required String name,
    required String phone,
    required String cr,
    required String vat,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'name': name,
        'phone': phone,
        'cr': cr,
        'vat': vat,
      });
    } catch (e) {
      // Handle the error
      print('Error creating user profile: $e');
    }
  }

  Future<void> updateUserProfile({
    required String userId,
    required String name,
    required String phone,
    required String cr,
    required String vat,
  }) async {
    try {
      // show loading
      Get.snackbar(
        'Loading',
        'please wait',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
      await _firestore.collection('users').doc(userId).update({
        'name': name,
        'phone': phone,
        'cr': cr,
        'vat': vat,
        "addresses": []
      });
    } catch (e) {
      // Handle the error
      Get.snackbar('Error', e.toString(),
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
    }
  }

  Future<UserProfile> getUserProfile(String userId) async {
    //  get user email
    var userData = await _firestore.collection('users').doc(userId).get();
    return UserProfile.fromSnapshot(userData);
  }

  Future<void> addPhoto(photo, userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({'photo': photo});
    } catch (e) {
      print('Error adding photo: $e');
    }
  }

  Future<void> addAddress({
    required String userId,
    required String address,
    required double lat,
    required double lng,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).update(
        {
          'addresses': FieldValue.arrayUnion([
            {
              'address': address,
              'lat': lat,
              'lng': lng,
            }
          ])
        },
      );
    } catch (e) {
      // Handle the error
      print('Error adding address: $e');
    }
  }

  // update password
  Future<void> updatePassword(String password) async {
    try {
      await _auth.currentUser!.updatePassword(password);
    } catch (e) {
      print('Error updating password: $e');
    }
  }

  // update email
  Future<void> updateEmail(String email) async {
    try {
      await _auth.currentUser!.updateEmail(email);
    } catch (e) {
      print('Error updating email: $e');
    }
  }
}

class Address {
  final String address;
  final double lat;
  final double lng;

  Address({
    required this.address,
    required this.lat,
    required this.lng,
  });
}

class UserProfile {
  final String name;
  final String phone;
  final String cr;
  final String vat;
  final String? photo;
// addressess
  final List<Address> addresses;

  UserProfile(
      {required this.name,
      required this.phone,
      required this.cr,
      this.photo,
      required this.vat,
      required this.addresses});

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    print(map);
    return UserProfile(
      name: map['name'],
      phone: map['phone'],
      cr: map['cr'],
      vat: map['vat'],
      photo: map['photo'] ?? '',
      addresses: map['addresses'] == null
          ? []
          : List<Address>.from(
              map['addresses'].map(
                (address) => Address(
                  address: address['address'],
                  lat: address['lat'],
                  lng: address['lng'],
                ),
              ),
            ),
    );
  }
  // from fromSnapshot
  factory UserProfile.fromSnapshot(DocumentSnapshot snapshot) {
    return UserProfile.fromMap(snapshot.data() as Map<String, dynamic>);
  }
}

const apiKey = 'AIzaSyC8_AQ4MtlbeQEHmHIHUWS8XbGemthwqgQ';
