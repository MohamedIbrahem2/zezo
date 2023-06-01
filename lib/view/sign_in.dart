import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/view/sign_up.dart';
import 'package:video_player/video_player.dart';
import '../constants.dart';
import '../view_model/auth_view_model.dart';
import '../widgets/custom_text_form.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var controller = Get.put(AuthViewModel());
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('videos/vid.mp4')
      ..initialize().then((value) {
        _controller.play();
        _controller.setLooping(false);
        setState(() {});
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    setState(() {
      _controller.dispose();
    });
  }

  var isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        opacity: .5,
        color: Colors.grey,
        progressIndicator: CircularProgressIndicator(),
        dismissible: true,
        inAsyncCall: isloading,
        child: GetBuilder<AuthViewModel>(
          init: AuthViewModel(),
          builder: (_) => Stack(
            children: [
              BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
              ),
              Container(
                width: Get.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Get.height * .25,
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: []),
                        width: Get.width * .9,
                        height: Get.height * .55,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
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
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Sign in to continue',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * .05,
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
                                onSave: (val) {
                                  controller.email = val;
                                },
                                validate: (val) {
                                  if (val == null) {
                                    return 'email is empty';
                                  }
                                },
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
                                onSave: (val) {
                                  controller.password = val;
                                },
                                validate: (val) {
                                  if (val == null) {
                                    return 'password is empty';
                                  }
                                },
                                obsecure: false,
                                secure: true,
                                hint: '*************',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'forget password?',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * .05,
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
                                      primary: mainColor,
                                      fixedSize:
                                          Size.fromWidth(Get.width * .8)),
                                  child: Text('SIGN IN'))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .05,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Get.offAll(SignUp());
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                          ),
                          child: Text('New Customer'))
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
