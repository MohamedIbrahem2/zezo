import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stockat/constants.dart';
import 'package:stockat/main.dart';
import 'package:stockat/widgets/custom_text_form.dart';

import '../../service/upload_image_service.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({Key? key}) : super(key: key);

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  File? _imageFile;
  String _imageUrl = '';
  bool isLoading = false;
  final FirebaseStorageService _storageService = FirebaseStorageService();
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  final authService = AuthService();
  final _fromKey = GlobalKey<FormState>();
  late Future<UserProfile> futute;
  // get user profile
  void getUserProfile() async {
    try {
      isLoading = true;
      setState(() {});
      userProfile = await authService
          .getUserProfile(FirebaseAuth.instance.currentUser!.uid);
      print('_______________________$userProfile');
      if (userProfile != null) {
        print('_______________________${userProfile!.name}');
        nameController.text = userProfile!.name;
        phoneController.text = userProfile!.phone;
        crController.text = userProfile!.cr;
        vatController.text = userProfile!.vat;
        emailController.text = FirebaseAuth.instance.currentUser!.email!;
      }
      isLoading = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    getUserProfile();
    //     .then((value) {
    //   userProfile = value;
    //   if (userProfile != null) {
    //     nameController.text = userProfile!.name;
    //     phoneController.text = userProfile!.phone;
    //     crController.text = userProfile!.cr;
    //     vatController.text = userProfile!.vat;
    //     emailController.text = FirebaseAuth.instance.currentUser!.email!;
    //   }
    //   setState(() {});
    // });
    super.initState();
  }

  Future<void> _uploadImage() async {
    try {
      if (_imageFile != null) {
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        print(fileName);
        String imageUrl =
            await _storageService.uploadImage(_imageFile!, fileName);
        setState(() {
          _imageUrl = imageUrl;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  String error = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController crController = TextEditingController();
  TextEditingController vatController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPhotoLoading = false;
  UserProfile? userProfile;
  Future<void> uploadUserPhoto(String _imageFile) async {
    try {
      isPhotoLoading = true;
      setState(() {});
      await authService.addPhoto(
          _imageFile, FirebaseAuth.instance.currentUser!.uid);
      userProfile = await authService
          .getUserProfile(FirebaseAuth.instance.currentUser!.uid);
      isPhotoLoading = false;
      setState(() {});
    } catch (e) {
      isPhotoLoading = false;
      setState(() {});
      Get.snackbar('Error', e.toString(),
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? getImagePovider(String? imageUrl) {
      if (imageUrl != null && imageUrl.isNotEmpty) {
        return NetworkImage(imageUrl);
      } else if (_imageFile != null) {
        return FileImage(_imageFile!);
      } else {
        return null;
      }
    }

    return Form(
      key: _fromKey,
      child: Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: SizedBox(
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
                            'Edit Profile'.tr,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                          radius: 80,
                          child: isPhotoLoading
                              ? const CircularProgressIndicator()
                              : InkWell(
                                  onTap: () async {
                                    await _pickImage();
                                    await _uploadImage();
                                    if (_imageUrl.isNotEmpty) {
                                      uploadUserPhoto(_imageUrl);
                                    }
                                  },
                                  child: getImagePovider(userProfile!.photo) !=
                                          null
                                      ? null
                                      : const Icon(
                                          Icons.add_a_photo,
                                          size: 40,
                                        ),
                                ),
                          backgroundImage: getImagePovider(userProfile!.photo),
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
                              // Container(
                              //   alignment: Alignment.topLeft,
                              //   child: const Text(
                              //     'Name',
                              //     style: TextStyle(
                              //         fontSize: 17,
                              //         fontWeight: FontWeight.w300,
                              //         color: Colors.grey),
                              //   ),
                              // ),
                              CustomTextForm(
                                  controller: nameController,
                                  obsecure: false,
                                  decoration: InputDecoration(
                                    labelText: 'Name'.tr,
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  )
                                  // hint: 'stockat',
                                  ),
                              const SizedBox(
                                height: 15,
                              ),
                              // Container(
                              //   alignment: Alignment.topLeft,
                              //   child: const Text(
                              //     'phone',
                              //     style: TextStyle(
                              //         fontSize: 17,
                              //         fontWeight: FontWeight.w300,
                              //         color: Colors.grey),
                              //   ),
                              // ),
                              CustomTextForm(
                                controller: phoneController,
                                obsecure: false,
                                decoration: InputDecoration(
                                  labelText: 'Phone Number'.tr,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                validate: (p0) {
                                  if (p0!.isEmpty) {
                                    return 'phone is required'.tr;
                                  } else if (p0.length < 10) {
                                    return 'phone must be valid'.tr;
                                  }

                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),

                              const SizedBox(
                                height: 15,
                              ),
                              // Container(
                              //   alignment: Alignment.topLeft,

                              //   child: const Text(
                              //     'Email',
                              //     style: TextStyle(
                              //         fontSize: 17,
                              //         fontWeight: FontWeight.w300,
                              //         color: Colors.grey),
                              //   ),
                              // ),
                              CustomTextForm(
                                controller: emailController,
                                obsecure: false,
                                decoration: InputDecoration(
                                  labelText: 'Email'.tr,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                validate: (p0) {
                                  if (p0!.isEmpty) {
                                    return 'email is required'.tr;
                                  } else if (!p0.contains('@')) {
                                    return 'email must be valid'.tr;
                                  }

                                  return null;
                                },
                              ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              // Container(
                              //   alignment: Alignment.topLeft,
                              //   child: const Text(
                              //     'Password',
                              //     style: TextStyle(
                              //         fontSize: 17,
                              //         fontWeight: FontWeight.w300,
                              //         color: Colors.grey),
                              //   ),
                              // ),
                              // CustomTextForm(
                              //   controller: passwordController,
                              //   obsecure: false,
                              //   secure: true,
                              //   hint: '*************',
                              //   validate: (p0) {
                              //     if (p0!.isEmpty) {
                              //       return 'password is required';
                              //     } else if (p0.length < 6) {
                              //       return 'password must be at least 6 characters';
                              //     }
                              //     return null;
                              //   },
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: Get.height * .03,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (_fromKey.currentState!.validate()) {
                                      authService.updateUserProfile(
                                        userId: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        // cr: crController.text,
                                        // vat: vatController.text,
                                      );
                                      // if (emailController.text.isNotEmpty) {
                                      //   authService
                                      //       .updateEmail(emailController.text);
                                      // }
                                    }
                                    setState(() {});
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: mainColor,
                                      fixedSize:
                                          Size.fromWidth(Get.width * .8)),
                                  child: const Text(
                                    'EDIT',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
