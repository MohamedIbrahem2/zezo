import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/constants.dart';
import 'package:stockat/widgets/custom_text_form.dart';

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * .07,
                ),
                Image.asset(
                  'logos/logo.jpg',
                  width: Get.width * .7,
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
                  height: Get.height * .99,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Welcome,',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: mainColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Sign in to continue',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey),
                          ),
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
                          onSave: (val) {
                            controller.name = val;
                          },
                          validate: (val) {
                            if (val == null) {
                              return 'email is empty';
                            }
                            return null;
                          },
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
                          onSave: (val) {
                            controller.phone = val;
                          },
                          validate: (val) {
                            if (val == null) {
                              return 'email is empty';
                            }
                            return null;
                          },
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
                          onSave: (val) {
                            controller.cr = val;
                          },
                          validate: (val) {
                            if (val == null) {
                              return 'email is empty';
                            }
                            return null;
                          },
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
                          onSave: (val) {
                            controller.vat = val;
                          },
                          validate: (val) {
                            if (val == null) {
                              return 'email is empty';
                            }
                            return null;
                          },
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
                          onSave: (val) {
                            controller.email = val!;
                          },
                          validate: (val) {
                            if (val == null) {
                              return 'email is empty';
                            }
                            return null;
                          },
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
                          onSave: (val) {
                            controller.password = val!;
                          },
                          validate: (val) {
                            if (val == null) {
                              return 'password is empty';
                            }
                            return null;
                          },
                          obsecure: false,
                          secure: true,
                          hint: '*************',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: const Text(
                            'forget password?',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
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
                            child: const Text('SIGN Up'))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * .05,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text('Already have an account?'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
