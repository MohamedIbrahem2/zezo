import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stockat/constants.dart';
import 'package:stockat/service/product_service.dart';
import 'package:stockat/widgets/shimmer.dart';

import '../main.dart';
import '../service/cart_service.dart';
import 'bottom_nav/cart.dart';
import 'bottom_nav/peoduct_details.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}


class _SearchState extends State<Search> {
  int count = 1;
  final TextEditingController searchValue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(const Screen2());
              },
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 15, top: 6),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 30,
                      color: Colors.white,
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
                          left: 18,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red
                            ),
                            width: 25,
                            height: 25,
                            child: Center(
                              child: Text(
                                quantity! >= 100 ?  "99+" : (snapshot.data == null ? '0' : quantity.toString()),
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ],
          backgroundColor: mainColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            textDirection: TextDirection.rtl,
            'البحث',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 40,
            ),
            child: Column(
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: searchValue,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            searchValue.text = "";
                            return;
                          });

                        }
                        setState(() {
                          searchValue.text = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'كل ما تريد !',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: Colors.black,
                          size: 25,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 1),
                        enabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                                width: 2,
                                color: mainColor
                            ),
                            borderRadius: BorderRadius.circular(25)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                                width: 3,
                                color: mainColor
                            ),

                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: Get.width,
                  height: Get.height * .83,
                  child: StreamBuilder<List<Product>>(
                      stream: ProductsService().searchForProduct(searchValue.text) ,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error'),
                          );
                        }

                        if (snapshot.connectionState == ConnectionState.waiting && searchValue.text != '') {
                          return buildShimmer();
                        }
                        if(searchValue.text != '') {
                          final products = snapshot.data;
                          return GridView.builder(
                              gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                  childAspectRatio: .8,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                              itemCount: products!.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onLongPress:() {
                                      final provider = Provider.of<AdminProvider>(context, listen: false);
                                      if(provider.isAdmin) {
                                        Get.defaultDialog(
                                            title: 'Do you want to delete ' +
                                                product.brand.tr + " Category ?",
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
                                                        .deleteProductFromBestSelling(
                                                        product.id);
                                                    ProductsService()
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
                                    onTap: () {
                                      final provider = Provider.of<AdminProvider>(context, listen: false);
                                      if(provider.isAdmin) {
                                        Get.to(ProductDetails(product: product));
                                      }
                                    },
                                    child: Container(

                                      height: Get.height * 0.09,
                                      width: Get.width * 0.4,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0.0, 1.0), //(x,y)
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(13)
                                      ),
                                      child: Column(
                                        //crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CachedNetworkImage(
                                              imageUrl: product.images.first,
                                              //fit: BoxFit.fill,
                                              imageBuilder: (context, imageProvider) =>
                                                  Container(
                                                    //  width: Get.width * .35,
                                                    height: Get.height * .115,
                                                    decoration: BoxDecoration(image: DecorationImage(image: imageProvider ,)
                                                    ),
                                                  ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Container(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                textDirection: TextDirection.rtl,
                                                product.title,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    height: .95,
                                                    overflow: TextOverflow.ellipsis,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              product.brand,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black45),
                                            ),
                                          ),
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(1.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      if (product.discountPrice > 0)
                                                        Stack(
                                                          alignment: Alignment.center,
                                                          children: [
                                                            Text(
                                                              product.regularPrice.toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.black),
                                                            ),
                                                            Container(
                                                              width: 15,
                                                              height: 1.5,
                                                              color: mainColor,
                                                            )
                                                          ],
                                                        ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      if (product.discountPrice > 0)
                                                        Text(
                                                          (product.regularPrice - product.discountPrice)
                                                              .toString(),
                                                          style:  TextStyle(
                                                              fontSize: 17,
                                                              fontWeight: FontWeight.bold,
                                                              color: mainColor),
                                                        ),
                                                      if (product.discountPrice == 0)
                                                        Text(
                                                          product.regularPrice.toString(),
                                                          style:  TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.bold,
                                                              color: mainColor),
                                                        ),

                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: Get.width * 0.065,
                                                    height: Get.height * 0.03,
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
                                                          productName: product.brand,
                                                          price: product.regularPrice -
                                                              product.discountPrice,
                                                          quantity: count,
                                                          userId: FirebaseAuth
                                                              .instance.currentUser!.uid, image: product.images.first,
                                                        );
                                                      },
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      style: ElevatedButton.styleFrom(
                                                          padding: EdgeInsets.zero,
                                                          backgroundColor: mainColor),
                                                    ),
                                                  ),
                                                )
                                              ]
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                        return const Center(child: Text("من فضلك اكتب اسم المنتج الذي تريد البحث عنه",textDirection: TextDirection.rtl,),);
                      }
                  ),
                )
              ],
            ),
          ),
        ));
  }
}