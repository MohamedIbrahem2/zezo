import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stockat/service/product_service.dart';

import '../../service/category_service.dart';
import '../../service/subcategory_service.dart';
import '../../service/upload_image_service.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({super.key, required this.product});
  final Product product;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
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

    nameController.text = widget.product.name;
    priceController.text = widget.product.price.toString();
    deiscountController.text = widget.product.discount.toString();
    _imageUrl = widget.product.image;

    CategoryService().getCategoryById(widget.product.categoryId).then((value) {
      setState(() {
        category = value;
      });
    });
    SubCategoryService()
        .getSubcategoryById(widget.product.subcategoryId)
        .then((value) {
      setState(() {
        subcategory = value;
      });
    });
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
      if (widget.product.image.isNotEmpty) {
        return NetworkImage(widget.product.image);
      }
      return null;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Product'),
        ),
        body: Form(
          key: _fromKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),

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
                              image: DecorationImage(
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

                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter products name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
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

                          // if (_imageFile == null) {
                          //   Get.snackbar('Error', 'Please select image');
                          //   return;
                          // }

                          try {
                            setState(() {
                              isLoading = true;
                            });
                            await _uploadImage();
                            if (_imageUrl.isNotEmpty) {
                              await ProductsService()
                                  .updateProduct(widget.product.copyWith(
                                name: nameController.text,
                                price: double.parse(priceController.text),
                                discount:
                                    double.parse(deiscountController.text),
                                image: _imageUrl,
                                categoryId: category!.id,
                                subcategoryId: subcategory!.id, available: widget.product.available,
                              ));
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
                      child: const Text('Update Category'),
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}
