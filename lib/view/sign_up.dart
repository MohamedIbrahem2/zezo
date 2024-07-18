import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:stockat/constants.dart';

import '../view_model/auth_view_model.dart';

class SignUp extends GetWidget<AuthViewModel> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cr = TextEditingController();
  TextEditingController vat = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  var controller = Get.put(AuthViewModel());

  SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: GetBuilder<AuthViewModel>(
        init: AuthViewModel(),
        builder: (_) => SizedBox(
          width: Get.width,
          child: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * .02,
                  ),
                  Image.asset(
                    'images/MYD logo2.png',
                    width: Get.width * .9,
                    height: Get.height * .2,
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
                    // height: Get.height * .99,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'أهلا بك !',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: const Text(
                              'أنشأ حسابك للاستمرار',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black45),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * .02,
                          ),
                          TextFormField(
                            controller: name,
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
                          SizedBox(
                            height: Get.height * .02,
                          ),

                          IntlPhoneField(
                            controller: phone,
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
                          // TextFormField(
                          //   controller: phone,
                          //   decoration: const InputDecoration(
                          //     labelText: 'Phone',
                          //     border: OutlineInputBorder(
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(10)),
                          //     ),
                          //   ),
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'Please enter phone';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          SizedBox(
                            height: Get.height * .02,
                          ),
                          TextFormField(
                            controller: email,
                            onChanged: (value) {
                              controller.email = value;
                            },
                            decoration:  InputDecoration(
                              labelText: 'البريد الالكتروني',
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
                                return 'Please enter email';
                              }

                              // regx
                              const pattern =
                                  r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
                              final regExp = RegExp(pattern);
                              if (!regExp.hasMatch(value)) {
                                return 'Please enter valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: Get.height * .02,
                          ),
                          TextFormField(
                            controller: password,
                            onChanged: (value) {
                              controller.password = value;
                            },
                            decoration:  InputDecoration(
                              labelText: 'الرقم السري',
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
                                return 'Please enter password';
                              }
                              // if have white space
                              if (value.contains(' ')) {
                                return 'password must not contain white space';
                              }
                              // have to be more than 8 char
                              if (value.length < 8) {
                                return 'Password must be more than 8 char';
                              }
                              return null;
                            },
                          ),

                          SizedBox(
                            height: Get.height * .03,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                formKey.currentState!.save();
                                if (formKey.currentState!.validate()) {
                                  controller.signUp();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor,
                                  fixedSize: Size.fromWidth(Get.width * .8)),
                              child: const Text('إنشاء حساب',style: TextStyle(color: Colors.white,fontSize: 18,
                              fontWeight: FontWeight.bold
                              ),))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * .035,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size.fromWidth(Get.width*.8),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text('هل لديك حساب بالفعل؟',style: TextStyle(color: Colors.white),))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
