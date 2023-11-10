import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:stockat/view/sign_up.dart';
import 'package:video_player/video_player.dart';

import '../constants.dart';
import '../widgets/custom_text_form.dart';

String formatFirebaseError(FirebaseAuthException exception) {
  String message = '';
  switch (exception.code) {
    case 'invalid-email':
      message = 'Invalid email address';
      break;
    case 'user-not-found':
      message = 'User not found';
      break;
    case 'wrong-password':
      message = 'Wrong password';
      break;
    case 'email-already-in-use':
      message = 'Email already in use';
      break;
    case 'weak-password':
      message = 'Password is too weak';
      break;
    case 'too-many-requests':
      message = 'Too many requests, please try again later';
      break;
    default:
      message = 'Something went wrong';
  }
  return message;
}

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late VideoPlayerController _controller;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isLoading = false;
  String error = '';
  Future sendResetLink() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim());
        setState(() {
          isLoading = false;
        });
        Get.back();
        showSimpleNotification(
          const Text('Reset link sent'),
          background: Colors.green,
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
          error = e.toString();
        });
        // show error message
        Get.snackbar('Error', formatFirebaseError(e),
            duration: const Duration(seconds: 5),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red);
      } catch (e) {
        setState(() {
          isLoading = false;
          error = e.toString();
        });
        Get.snackbar('Error', error,
            duration: const Duration(seconds: 5),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red);
      }
    }
  }

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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                    height: Get.height * .25,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const []),
                    width: Get.width * .9,
                    height: Get.height * .55,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     const Text(
                          //       'Welcome,',
                          //       style: TextStyle(
                          //           fontSize: 30,
                          //           fontWeight: FontWeight.w500,
                          //           color: Colors.black),
                          //     ),
                          //     Text(
                          //       '',
                          //       style: TextStyle(
                          //           fontSize: 20,
                          //           fontWeight: FontWeight.w700,
                          //           color: mainColor),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Forget Password',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Enter your email address below to send you a reset password link',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * .02,
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
                            controller: emailController,
                            onSave: (val) {
                              // controller.email = val!;
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
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              child: const Text(
                                'Back to Login?',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                sendResetLink();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor,
                                  fixedSize: Size.fromWidth(Get.width * .8)),
                              child: const Text('Send Reset Link'))
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
                        backgroundColor: Colors.black,
                      ),
                      child: const Text('New Customer'))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
