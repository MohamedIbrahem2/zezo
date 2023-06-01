import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/constants.dart';
import 'package:stockat/view/sign_in.dart';
import 'package:stockat/widgets/custom_text_form.dart';

class Editprofile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * .07,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Edit your profile',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                child: CircleAvatar(
                  child: Icon(
                    Icons.camera_enhance_rounded,
                    size: 35,
                  ),
                  radius: 35,
                  backgroundColor: Colors.blue.shade100,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [BoxShadow(blurRadius: 2, color: Colors.grey)]),
                width: Get.width * .9,
                height: Get.height * .92,
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                    ),
                    CustomTextForm(
                      obsecure: false,
                      hint: 'stockat',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'phone',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                    ),
                    CustomTextForm(
                      obsecure: false,
                      hint: '0540814644',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'C.R',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                    ),
                    CustomTextForm(
                      obsecure: false,
                      hint: '3185400003',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'vat number',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                    ),
                    CustomTextForm(
                      obsecure: false,
                      hint: '318540003',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                    ),
                    CustomTextForm(
                      obsecure: false,
                      hint: 'stockat@gmail.com',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                    ),
                    CustomTextForm(
                      obsecure: false,
                      secure: true,
                      hint: '*************',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: Get.height * .03,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: mainColor,
                            fixedSize: Size.fromWidth(Get.width * .8)),
                        child: Text(
                          'EDIT',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
