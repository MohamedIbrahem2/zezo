import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stockat/service/product_service.dart';

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
                        final quantity = (snapshot.data == null ||
                                snapshot.data!.isEmpty)
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
          title: const Text(
            'Search',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 40,
          ),
          child: Column(
            children: [
              Padding(
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
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      size: 30,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 1),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
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
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
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
                                            product.name.tr + " Product ?",
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
                                      child: Image.network(product.image),
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
                                        onPressed: () {
                                          CartService().addToCart(
                                            productId: product.id,
                                            productName: product.name,
                                            price: product.price -
                                                product.discount,
                                            quantity: 1,
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
                                            SizedBox(
                                              width: 4,
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
                        return const Center(child: Text("Type Your product name "),);
                        }
                    ),
              )
            ],
          ),
        ));
  }
}
