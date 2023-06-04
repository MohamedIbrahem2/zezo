import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/constants.dart';
import 'package:stockat/widgets/custom_text_form.dart';

class Editprofile extends StatelessWidget {
  const Editprofile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
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
                child: const Text(
                  'Edit your profile',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                child: CircleAvatar(
                  child: const Icon(
                    Icons.camera_enhance_rounded,
                    size: 35,
                  ),
                  radius: 35,
                  backgroundColor: Colors.blue.shade100,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(blurRadius: 2, color: Colors.grey)
                    ]),
                width: Get.width * .9,
                height: Get.height * .92,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
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
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
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
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
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
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
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
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
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
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
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
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: Get.height * .03,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            fixedSize: Size.fromWidth(Get.width * .8)),
                        child: const Text(
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
