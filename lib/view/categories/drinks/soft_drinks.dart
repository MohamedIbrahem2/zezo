import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stockat/main.dart';
import 'package:stockat/service/product_service.dart';
import 'package:stockat/view/search.dart';
import 'package:stockat/view_model/drinks/soft_-drinks_viewmodel.dart';

import '../../../service/cart_service.dart';
import '../../bottom_nav/cart.dart';
import '../../bottom_nav/peoduct_details.dart';

class SubCategoriesProducts extends StatefulWidget {
  const SubCategoriesProducts(
      {Key? key,
      required this.subCategoryId,
      required this.categoryId,
      required this.subCategoryName})
      : super(key: key);
  final String subCategoryId;
  final String categoryId;
  final String subCategoryName;
  @override
  State<SubCategoriesProducts> createState() => _DrinksItemsState();
}

class _DrinksItemsState extends State<SubCategoriesProducts> {
  int count = 1;
  var controller = Get.put(SoftDrinksViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              Get.to(const Search());
              // setState(() {
              //   Get.defaultDialog(
              //       title: 'search',
              //       barrierDismissible: false,
              //       middleText: 'Search',
              //       content: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 20),
              //         child: TextFormField(
              //           decoration: InputDecoration(
              //               enabledBorder: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(20))),
              //         ),
              //       ));
              // });
            },
          ),
          GestureDetector(
            onTap: () {
              Get.to(const Screen2());
            },
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 15, top: 10),
                  child: Icon(
                    Icons.shopping_cart,
                    size: 40,
                    color: Colors.blue,
                  ),
                ),
                StreamBuilder<List<CartItem>>(
                    stream: CartService()
                        .getCartItems(FirebaseAuth.instance.currentUser!.uid),
                    builder: (context, snapshot) {
                      final quantity =
                          (snapshot.data == null || snapshot.data!.isEmpty)
                              ? 0
                              : snapshot.data
                                  ?.map((e) => e.quantity)
                                  .reduce((value, element) => value + element);
                      return Positioned(
                        top: 3,
                        left: 14,
                        child: Text(
                          snapshot.data == null ? '0' : quantity.toString(),
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    })
              ],
            ),
          ),
        ],
        backgroundColor: Colors.blue.shade50,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.subCategoryName,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: GetBuilder<SoftDrinksViewModel>(
        init: SoftDrinksViewModel(),
        builder: (_) => Column(
          children: [
            // TextButton(
            //     onPressed: () {
            //       ProductsService().addProduct(
            //           '7 up 2L',
            //           10,
            //           3,
            //           'https://m.media-amazon.com/images/I/617MzyCetcL.jpg',
            //           widget.categoryId,
            //           widget.subCategoryId);
            //       ProductsService().addProduct(
            //           '7 up 1L',
            //           20,
            //           3,
            //           'https://m.media-amazon.com/images/I/617MzyCetcL.jpg',
            //           widget.categoryId,
            //           widget.subCategoryId);
            //     },
            //     child: const Text('ADD products')),
            Container(
              margin: const EdgeInsets.all(10),
              width: Get.width,
              height: Get.height * .8,
              child: StreamBuilder<List<Product>>(
                  stream: ProductsService()
                      .getProductsBySubcategory(widget.subCategoryId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error'),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final products = snapshot.data;

                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300,
                                childAspectRatio: .7,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount: products!.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return InkWell(
                            onTap: () {
                              final provider = Provider.of<AdminProvider>(context, listen: false);
                              if (provider.isAdmin) {
                                Get.to(() => ProductDetails(
                                      product: product,
                                    ));
                              }
                            },
                            onLongPress: (){
                              final provider = Provider.of<AdminProvider>(context, listen: false);
                              if(provider.isAdmin) {
                                Get.defaultDialog(
                                    title: 'Do you want to delete ' +
                                        product.name.tr + " product ?",
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
                                                .deleteProduct(
                                                product.id);
                                            Navigator.pop(context);
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5,
                                            spreadRadius: 2,
                                            color: Colors.grey),
                                      ]),
                                  child: CachedNetworkImage(
                                      imageUrl: product.image),
                                  width: Get.width * .4,
                                  height: Get.height * .14,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (product.discount > 0)
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Text(
                                            product.price.toString(),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                          Container(
                                            width: 20,
                                            height: 1.5,
                                            color: Colors.grey.shade700,
                                          )
                                        ],
                                      ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    if (product.discount > 0)
                                      Text(
                                        (product.price - product.discount)
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                    if (product.discount == 0)
                                      Text(
                                        (product.price).toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                  ],
                                ),
                                SizedBox(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final result = await CartService()
                                          .isProductInCart(
                                              product.id,
                                              FirebaseAuth
                                                  .instance.currentUser!.uid);
                                      // if (result != null && result > 0) {
                                      //   // remove snakebar

                                      //   Get.snackbar(
                                      //       'Sorry', 'Product already in cart');
                                      // }
                                      CartService().addToCart(
                                        productId: product.id,
                                        productName: product.name,
                                        price: product.price - product.discount,
                                        quantity: count,
                                        image: product.image,
                                        userId: FirebaseAuth
                                            .instance.currentUser!.uid,
                                      );
                                    },
                                    child: const Row(
                                      children: [
                                        Text(
                                          'Get',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),

                                        Icon(
                                          Icons.add_shopping_cart,
                                          color: Colors.white,
                                        )
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green),
                                  ),
                                  width: Get.width * .25,
                                ),
                              ],
                            ),
                          );
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
