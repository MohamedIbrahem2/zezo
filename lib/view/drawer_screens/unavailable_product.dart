import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../service/cart_service.dart';
import '../../service/product_service.dart';
import '../bottom_nav/peoduct_details.dart';
class UnavailableProduct extends StatefulWidget {
  const UnavailableProduct({super.key});

  @override
  State<UnavailableProduct> createState() => _UnavailableProductState();
}

class _UnavailableProductState extends State<UnavailableProduct> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Unavailable Products'),
      ),
      body: StreamBuilder<List<Product>>(
          stream: ProductsService().getUnavailableProducts(),
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
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: .7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: products!.length
                , itemBuilder: (context, index){
              final product = products[index];
              return InkWell(
                onTap: () {
                  final provider = Provider.of<AdminProvider>(context, listen: false);
                  if (provider.isAdmin) {
                    Get.to(() => ProductDetails(
                      product: product, uniqueId: '',
                    ));
                  }
                },
                onLongPress: (){
                  final provider = Provider.of<AdminProvider>(context, listen: false);
                  if(provider.isAdmin) {
                    Get.defaultDialog(
                        title: 'Do you want to delete ' +
                            product.brand.tr + " product ?",
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
                                ProductsService()
                                    .deleteProductFromBestSelling(
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
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      product.brand,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (product.discountPrice > 0)
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                product.regularPrice.toString(),
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
                        if (product.discountPrice > 0)
                          Text(
                            (product.regularPrice - product.discountPrice)
                                .toString(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        if (product.discountPrice == 0)
                          Text(
                            (product.regularPrice).toString(),
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
                              productName: product.brand,
                              price: product.regularPrice -
                                  product.discountPrice,
                              quantity: count,
                              image: '',
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
          }
      ),
    );
  }
}
