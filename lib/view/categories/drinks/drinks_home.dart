import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stockat/service/category_service.dart';
import 'package:stockat/service/product_service.dart';
import 'package:stockat/service/products_service.dart';
import 'package:stockat/view/categories/drinks/soft_drinks.dart';

import '../../../main.dart';
import '../../../service/subcategory_service.dart';

class SubCategoriesScreen extends StatefulWidget {
  const SubCategoriesScreen({Key? key, required this.categoryId})
      : super(key: key);
  final String categoryId;

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  final TextEditingController searchValue = TextEditingController();
  late Future<Category> getCategoryFuture;
  @override
  void initState() {
    getCategoryFuture = CategoryService().getCategory(widget.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: FutureBuilder<Category>(
          future: getCategoryFuture,
          builder: (context, state) {
            if (state.hasData) {
              final category = state.data;
              final name = category == null ? '' : category.name;
              return Text(
                name,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              );
            }
            return const Text(
              '...',
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            );
          },
        ),
        backgroundColor: Colors.blue.shade50,
      ),
      body: Column(
        children: [
          SizedBox(
            height: Get.height * .04,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    searchValue.text = '';
                    return;
                  });
                } else {
                  setState(() {
                    searchValue.text = value;
                  });
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  size: 30,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 1),
                enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * .03,
          ),
          Expanded(
            child: StreamBuilder<List<Subcategory>>(
                stream: SubCategoryService().searchSubcategoriesByCategory(
                    searchValue.text, widget.categoryId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final subcategories = snapshot.data;
                  return GridView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                      itemCount: subcategories!.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemBuilder: (c, index) {
                        final subcategory = subcategories[index];
                        return GestureDetector(
                          onLongPress: (){
                            final provider = Provider.of<AdminProvider>(context, listen: false);
                            if(provider.isAdmin) {
                              Get.defaultDialog(
                                  title: 'Do you want to delete ' +
                                      subcategory.name.tr + " Subcategory ?",
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'no'.tr,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            elevation: 10),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await ProductsService()
                                              .deleteSubcategory(
                                              subcategory.id);
                                          Navigator.pop(context);
                                          print(subcategory.id);
                                        },
                                        child: Text('yes'.tr,
                                            style: const TextStyle(
                                                color: Colors.white)),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            elevation: 10),
                                      ),
                                    ],
                                  ));
                            }
                          },
                          onTap: () {
                            Get.to(SubCategoriesProducts(
                                subCategoryId: subcategory.id,
                                categoryId: widget.categoryId,
                                subCategoryName: subcategory.name));
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          color: Colors.grey)
                                    ]),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: CachedNetworkImage(
                                  imageUrl: subcategory.image,
                                  fit: BoxFit.fill,
                                ),
                                width: Get.width * .4,
                                height: Get.height * .15,
                              ),
                              Text(
                                subcategory.name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        );
                      });
                }),
          ),

          // TextButton(
          //     onPressed: () {
          //       SubCategoryService().addSubcategory('Soft Drinks', categoryId,
          //           'https://sagaciresearch.com/wp-content/uploads/2019/09/Top-10-Carbonated-Soft-Drinks-Egypt-V3.jpg');

          //       SubCategoryService().addSubcategory('Water', categoryId,
          //           'https://5.imimg.com/data5/MU/JT/MY-1198768/mineral-water-bottle-500x500.jpg');
          //     },
          //     child: const Text('add subCategory')),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Get.to(const SoftDrinks());
          //       },
          //       child: Column(
          //         children: [
          //           Container(
          //             decoration: const BoxDecoration(
          //                 color: Colors.white,
          //                 boxShadow: [
          //                   BoxShadow(
          //                       spreadRadius: 2,
          //                       blurRadius: 5,
          //                       color: Colors.grey)
          //                 ]),
          //             margin: const EdgeInsets.only(bottom: 10),
          //             child: Image.network(
          //               'https://sagaciresearch.com/wp-content/uploads/2019/09/Top-10-Carbonated-Soft-Drinks-Egypt-V3.jpg',
          //               fit: BoxFit.fill,
          //             ),
          //             width: Get.width * .4,
          //             height: Get.height * .15,
          //           ),
          //           const Text(
          //             'Soft drinks',
          //             style: TextStyle(
          //                 fontSize: 18, fontWeight: FontWeight.bold),
          //           )
          //         ],
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         Get.to(const Water());
          //       },
          //       child: Column(
          //         children: [
          //           Container(
          //             decoration: const BoxDecoration(
          //                 color: Colors.white,
          //                 boxShadow: [
          //                   BoxShadow(
          //                       spreadRadius: 2,
          //                       blurRadius: 5,
          //                       color: Colors.grey)
          //                 ]),
          //             margin: const EdgeInsets.only(bottom: 10),
          //             child: Image.network(
          //               'https://5.imimg.com/data5/MU/JT/MY-1198768/mineral-water-bottle-500x500.jpg',
          //               fit: BoxFit.fill,
          //             ),
          //             width: Get.width * .4,
          //             height: Get.height * .15,
          //           ),
          //           const Text(
          //             'Water',
          //             style: TextStyle(
          //                 fontSize: 18, fontWeight: FontWeight.bold),
          //           )
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 30,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Get.to(const Energy());
          //       },
          //       child: Column(
          //         children: [
          //           Container(
          //             decoration: const BoxDecoration(
          //                 color: Colors.white,
          //                 boxShadow: [
          //                   BoxShadow(
          //                       spreadRadius: 2,
          //                       blurRadius: 5,
          //                       color: Colors.grey)
          //                 ]),
          //             margin: const EdgeInsets.only(bottom: 10),
          //             child: Image.network(
          //               'https://www.bigbasket.com/media/uploads/p/l/13377_2-red-bull-energy-drink.jpg',
          //               fit: BoxFit.fill,
          //             ),
          //             width: Get.width * .4,
          //             height: Get.height * .15,
          //           ),
          //           const Text(
          //             'Energy drinks',
          //             style: TextStyle(
          //                 fontSize: 18, fontWeight: FontWeight.bold),
          //           )
          //         ],
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         Get.to(const Juices());
          //       },
          //       child: Column(
          //         children: [
          //           Container(
          //             decoration: const BoxDecoration(
          //                 color: Colors.white,
          //                 boxShadow: [
          //                   BoxShadow(
          //                       spreadRadius: 2,
          //                       blurRadius: 5,
          //                       color: Colors.grey)
          //                 ]),
          //             margin: const EdgeInsets.only(bottom: 10),
          //             child: Image.network(
          //               'https://stylesatlife.com/wp-content/uploads/2019/11/Best-Juices-for-Pregnancy-Along-with-Benefits-and-Recipes.jpg.webp',
          //               fit: BoxFit.fill,
          //             ),
          //             width: Get.width * .4,
          //             height: Get.height * .15,
          //           ),
          //           const Text(
          //             'Juices',
          //             style: TextStyle(
          //                 fontSize: 18, fontWeight: FontWeight.bold),
          //           )
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 30,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Get.to(const Malt());
          //       },
          //       child: Column(
          //         children: [
          //           Container(
          //             decoration: const BoxDecoration(
          //                 color: Colors.white,
          //                 boxShadow: [
          //                   BoxShadow(
          //                       spreadRadius: 2,
          //                       blurRadius: 5,
          //                       color: Colors.grey)
          //                 ]),
          //             margin: const EdgeInsets.only(bottom: 10),
          //             child: Image.network(
          //               'https://cdn11.bigcommerce.com/s-58uvul1jf2/product_images/uploaded_images/allmalt.jpeg',
          //               fit: BoxFit.fill,
          //             ),
          //             width: Get.width * .4,
          //             height: Get.height * .15,
          //           ),
          //           const Text(
          //             'Malt drinks',
          //             style: TextStyle(
          //                 fontSize: 18, fontWeight: FontWeight.bold),
          //           )
          //         ],
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         Get.to(const CoffeTea());
          //       },
          //       child: Column(
          //         children: [
          //           Container(
          //             decoration: const BoxDecoration(
          //                 color: Colors.white,
          //                 boxShadow: [
          //                   BoxShadow(
          //                       spreadRadius: 2,
          //                       blurRadius: 5,
          //                       color: Colors.grey)
          //                 ]),
          //             margin: const EdgeInsets.only(bottom: 10),
          //             child: Image.network(
          //               'https://monsieurcoffee.com/wp-content/uploads/2021/07/is-coffee-technically-a-tea.jpg',
          //               fit: BoxFit.fill,
          //             ),
          //             width: Get.width * .4,
          //             height: Get.height * .15,
          //           ),
          //           const Text(
          //             'tea & coffe',
          //             style: TextStyle(
          //                 fontSize: 18, fontWeight: FontWeight.bold),
          //           )
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 30,
          // ),
          // GestureDetector(
          //   onTap: () {
          //     Get.to(const Milk());
          //   },
          //   child: Column(
          //     children: [
          //       Container(
          //         decoration: const BoxDecoration(
          //             color: Colors.white,
          //             boxShadow: [
          //               BoxShadow(
          //                   spreadRadius: 2,
          //                   blurRadius: 5,
          //                   color: Colors.grey)
          //             ]),
          //         margin: const EdgeInsets.only(bottom: 10),
          //         child: Image.network(
          //           'https://cdnprod.mafretailproxy.com/sys-master-root/h22/hd6/44240658333726/1700Wx1700H_77049_1.jpg',
          //           fit: BoxFit.fill,
          //         ),
          //         width: Get.width * .4,
          //         height: Get.height * .15,
          //       ),
          //       const Text(
          //         'Milk',
          //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}