import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stockat/view_model/auth_view_model.dart';

import '../../service/upload_image_service.dart';

class PrfileScreen extends StatefulWidget {
  const PrfileScreen({super.key});

  @override
  State<PrfileScreen> createState() => _PrfileScreenState();
}

class _PrfileScreenState extends State<PrfileScreen> {
  File? _imageFile;
  String _imageUrl = '';
  final FirebaseStorageService _storageService = FirebaseStorageService();
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // setState(() {
      //   _imageFile = File(pickedImage.path);
      // });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile != null) {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      String imageUrl =
          await _storageService.uploadImage(_imageFile!, fileName);
      setState(() {
        _imageUrl = imageUrl;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  bool isLoading = false;
  String error = '';
  final _fromKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cr = TextEditingController();
  TextEditingController vat = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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

    return GetBuilder<AuthViewModel>(builder: (conroller) {
      name.text = conroller.userProfile!.name;
      phone.text = conroller.userProfile!.phone;
      cr.text = conroller.userProfile!.cr;
      vat.text = conroller.userProfile!.vat;
      _imageUrl = conroller.userProfile!.photo ?? '';

      return Form(
        key: _fromKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(conroller.isPhotoLoading.toString()),
                  // pick image button
                  CircleAvatar(
                    radius: 80,
                    child: conroller.isPhotoLoading
                        ? const CircularProgressIndicator()
                        : InkWell(
                            onTap: () async {
                              await _pickImage();
                              await _uploadImage();
                              if (_imageUrl.isNotEmpty) {
                                conroller.uploadUserPhoto(_imageUrl);
                              }
                            },
                            child:
                                getImagePovider(conroller.userProfile!.photo) !=
                                        null
                                    ? null
                                    : const Icon(
                                        Icons.add_a_photo,
                                        size: 40,
                                      ),
                          ),
                    backgroundImage:
                        getImagePovider(conroller.userProfile!.photo),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  // upload image button

                  const SizedBox(
                    height: 20,
                  ),
                  // name of category
                  const Row(
                    children: [
                      Text('Name'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter category name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      Text('Phone'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter phone';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      Text('cr'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter cr';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      Text('vat'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter vat';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // add button
                  ElevatedButton(
                    onPressed: () async {
                      if (_fromKey.currentState!.validate()) {
                        try {
                          // setState(() {
                          //   isLoading = true;
                          // });
                          // await _uploadImage();
                          // if (_imageUrl.isNotEmpty) {
                          //   await CategoryService()
                          //       .addCategory(nameController.text, _imageUrl);
                          //   setState(() {
                          //     isLoading = false;
                          //   });
                          //   Get.back();
                          //   Get.snackbar(
                          //       'Success', 'Category added successfully');
                          // }
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                            error = e.toString();
                          });
                        }
                      }
                    },
                    child: const Text('Add Category'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
