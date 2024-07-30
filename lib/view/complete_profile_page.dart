import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:stockat/constants.dart';
import 'package:stockat/view/home_view.dart';

import '../view_model/auth_view_model.dart';
class CompleteProfilePage extends StatefulWidget {
  final User? user;

  CompleteProfilePage({this.user});

  @override
  _CompleteProfilePageState createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var controller = Get.put(AuthViewModel());
  Future<void> _saveProfile() async {
    await _firestore.collection('users').doc(widget.user!.uid).set({
      'name': _nameController.text,
      'phone': _phoneController.text,
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeView()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: mainColor,
          title: Text('اعداد الصفحه الشخصيه',
            textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _nameController,
                onChanged: (value) {
                  controller.name = value;
                },
                decoration:  InputDecoration(
                  labelText: 'الاسم',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor,width: 2.0),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: IntlPhoneField(
                controller: _phoneController,
                decoration:  InputDecoration(
                  labelText: 'رقم الهاتف',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor,width: 2.0),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                initialCountryCode: 'SA',
                onChanged: (value) {
                  controller.phone = value.completeNumber;
                },
                validator: (value) {
                  if (value!.number.isEmpty) {
                    return 'Please enter phone';
                  }
                  // regx
                  const pattern =
                      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
                  final regExp = RegExp(pattern);
                  if (!regExp.hasMatch(value.number)) {
                    return 'Please enter valid phone';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    fixedSize: Size.fromWidth(Get.width * .8)),
                child: const Text('حفظ البيانات',style: TextStyle(color: Colors.white,fontSize: 18,
                    fontWeight: FontWeight.bold
                ),))
          ],
        ),
      ),
    );
  }
}
