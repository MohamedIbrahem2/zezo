import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stockat/service/category_service.dart';
import 'package:stockat/service/subcategory_service.dart';

import '../../service/product_service.dart';
import '../../service/upload_image_service.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  File? _imageFile;
  String _imageUrl = '';
  final FirebaseStorageService _storageService = FirebaseStorageService();
  final ImagePicker _imagePicker = ImagePicker();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final deiscountController = TextEditingController();
  @override
  void initState() {
    priceController.text = '0';
    deiscountController.text = '0';

    // priceController.addListener(() {
    //   if (priceController.text.isEmpty) {
    //     priceController.text = '0';
    //   }
    // });
    // deiscountController.addListener(() {
    //   if (deiscountController.text.isEmpty) {
    //     deiscountController.text = '0';
    //   }
    // });
    super.initState();
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
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

  bool isLoading = false;
  String error = '';
  final _fromKey = GlobalKey<FormState>();

  Category? category;
  Subcategory? subcategory;

  @override
  Widget build(BuildContext context) {
    ImageProvider? getImagePovider() {
      if (_imageFile != null) {
        return FileImage(_imageFile!);
      }
      return null;
    }

    return Form(
      key: _fromKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Products'),
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
                // pick image button

                const SizedBox(
                  height: 20,
                ),
                StreamBuilder<List<Category>>(
                    stream: CategoryService().getCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('error'),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final categories = snapshot.data;
                      return DropdownButtonFormField<Category>(
                          value: category,
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          items: categories!
                              .map((e) => DropdownMenuItem<Category>(
                                    child: Text(e.name),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (v) {
                            setState(() {
                              category = v;
                              subcategory = null;
                            });
                            print(category);
                          });
                    }),
                const SizedBox(
                  height: 20,
                ),
                if (category != null)
                  StreamBuilder<List<Subcategory>>(
                      stream: SubCategoryService()
                          .getSubcategoriesByCategory(category!.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('error'),
                          );
                        }
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final subcategories = snapshot.data;
                        return DropdownButtonFormField<Subcategory>(
                            value: subcategory,
                            decoration: const InputDecoration(
                              labelText: 'Subcategory',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            items: subcategories!
                                .map((e) => DropdownMenuItem<Subcategory>(
                                      child: Text(e.name),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (v) {
                              setState(() {
                                subcategory = v;
                              });
                              print(category);
                            });
                      }),
                const SizedBox(
                  height: 20,
                ),

                // upload image button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: _pickImage,
                      child: Container(
                        height: 100,
                        width: 100,
                        child: const Icon(Icons.image),
                        decoration: BoxDecoration(
                            image: _imageFile == null
                                ? null
                                : DecorationImage(
                                    image: getImagePovider()!,
                                    fit: BoxFit.cover,
                                  ),
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // name of category

                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter products name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Porduct Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: priceController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter price';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: deiscountController,
                  decoration: const InputDecoration(
                    labelText: 'discount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // add button
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  ElevatedButton(
                    onPressed: () async {
                      if (_fromKey.currentState!.validate()) {
                        print(category);
                        if (category == null) {
                          Get.snackbar('Error', 'Please select category');
                          return;
                        }

                        if (subcategory == null) {
                          Get.snackbar('Error', 'Please select subcategory');
                          return;
                        }

                        if (_imageFile == null) {
                          Get.snackbar('Error', 'Please select image');
                          return;
                        }

                        try {
                          setState(() {
                            isLoading = true;
                          });
                          await _uploadImage();
                          if (_imageUrl.isNotEmpty) {
                            await ProductsService().addProduct(
                              productName: nameController.text,
                              image: _imageUrl,
                              categoryId: category!.id,
                              subcategoryId: subcategory!.id,
                              productPrice: priceController.text.isEmpty
                                  ? 0
                                  : double.parse(priceController.text),
                              discount: deiscountController.text.isEmpty
                                  ? 0
                                  : double.parse(deiscountController.text), available: false,
                            );
                            setState(() {
                              isLoading = false;
                            });
                            Get.back();
                            Get.snackbar(
                                'Success', 'Products added successfully');
                          }
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                            error = e.toString();
                          });
                        }
                      }
                    },
                    child: const Text('Add Product'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
