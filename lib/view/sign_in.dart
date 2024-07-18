import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:stockat/view/sign_up.dart';

import '../constants.dart';
import '../view_model/auth_view_model.dart';
import 'forget_password_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var controller = Get.put(AuthViewModel());
  // late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.asset('videos/vid.mp4')
    //   ..initialize().then((value) {
    //     _controller.play();
    //     _controller.setLooping(false);
    //     setState(() {});
    //   });
  }


  var isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        opacity: .5,
        color: Colors.grey,
        progressIndicator: const CircularProgressIndicator(),
        dismissible: true,
        inAsyncCall: isloading,
        child: GetBuilder<AuthViewModel>(
          init: AuthViewModel(),
          builder: (_) => Stack(
            children: [
              // BackdropFilter(
              //   filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              //   child: SizedBox.expand(
              //     child: FittedBox(
              //       fit: BoxFit.cover,
              //       child: SizedBox(
              //         width: MediaQuery.of(context).size.width,
              //         height: MediaQuery.of(context).size.height,
              //         child: VideoPlayer(_controller),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                width: Get.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Get.height * .02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Center(child: Image.asset('images/MYD logo2.png')),
                      ),

                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const []),
                        width: Get.width * .9,
                        // height: Get.height * .55,
                        child: Form(
                          key: formKey,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'أهلا بعودتك !',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),

                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: const Text(
                                    'سجل دخولك للاستمرار',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black45),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * .03,
                                ),
                                TextFormField(
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
                                const SizedBox(
                                  height: 13,
                                ),
                                TextFormField(
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
                                const SizedBox(
                                  height: 7,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(const ForgetPasswordPage());
                                  },
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    child: const Text(
                                      'هل نسيت كلمة السر؟',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        decoration: TextDecoration.underline

                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * .035,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isloading = true;
                                        formKey.currentState!.save();
                                        if (formKey.currentState!.validate()) {
                                          controller.signIn();
                                          isloading = false;
                                        }
                                        isloading = false;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor,
                                        fixedSize:
                                            Size.fromWidth(Get.width * .8)),
                                    child: const Text('تسجيل الدخول',style: TextStyle(color: Colors.white,fontSize: 18
                                    ,fontWeight: FontWeight.bold
                                    ),))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text('-او سجل باستخدام-',style: TextStyle(color: Colors.black,fontSize: 17
                          ,fontWeight: FontWeight.bold
                      ),),
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 50,
                          height: 35,
                         // color: Colors.grey,
                          child: Image.asset('images/google (1).png'),
                        ) ,
                          Container(
                            child: Image.asset('images/facebook.png'),
                            margin: EdgeInsets.all(10),
                          width: 50,
                          height: 35,
                         // color: Colors.white,
                        )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * .035,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Get.to(SignUp());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            fixedSize: Size.fromWidth(Get.width*.8)
                          ),
                          child: const Text(
                            'هل انت مستخدم جديد؟',
                            style: TextStyle(color: Colors.white
                            ,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
