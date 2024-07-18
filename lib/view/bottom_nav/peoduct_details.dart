import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/constants.dart';
import 'package:stockat/view/bottom_nav/edit_product.dart';

import '../../service/cart_service.dart';
import '../../service/product_service.dart';
import '../my_page_screens/qr_product_view.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late Product product;

  @override
  void initState() {
    product = widget.product;

    ProductsService().getProductById(product.id).then((event) {
      setState(() {
        product = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('تفاصيل المنتج',textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: CarouselSlider(
                    options: CarouselOptions(height: Get.height * 0.36),
                    items: product.images.map((url) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: Get.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    url,
                                    fit: BoxFit.fill,
                                  ),
                                )),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // edit product button
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await Get.to(EditProduct(product: product));
                              print('product id: ${product.id}');
                              ProductsService()
                                  .getProductById(product.id)
                                  .then((event) {
                                setState(() {
                                  product = event;
                                });
                              });
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          SizedBox(width: Get.width * 0.03),

                          // qr code button

                          IconButton(
                              onPressed: () {
                                Get.to(ProductQrImageView(
                                    id: product.id,
                                    productName: product.brand));
                              },
                              icon: const Icon(Icons.qr_code_scanner_outlined))

                          // IconButton(
                          //   onPressed: () {
                          //     // ProductService().deleteProduct(product.id);
                          //     Navigator.pop(context);
                          //   },
                          //   icon: const Icon(Icons.delete),
                          // ),
                        ],
                      ),

                      Text(
                        product.brand,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.03),
                      Text(
                        textDirection: TextDirection.rtl,
                        product.description,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.03),
                      Text(
                        textDirection: TextDirection.rtl,
                        'السعر: SR ${product.regularPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.03),
                      Text(
                        textDirection: TextDirection.rtl,
                        'التخفيض: ${product.discountPrice}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.03),
                      // Text(
                      //   'Category: ${product.categoryId}',
                      //   style: const TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.normal,
                      //   ),
                      // ),
                      // const SizedBox(height: 8),
                      // Text(
                      //   'Subcategory: ${product.subcategoryId}',
                      //   style: const TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.normal,
                      //   ),
                      // ),
                      // const SizedBox(height: 8),
                      // Text(
                      //   'Sales Count: ${product.salesCount}',
                      //   style: const TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.normal,
                      //   ),
                      // ),
                      SizedBox(height: Get.height * 0.03),
                      // total price
                      Text(
                        textDirection: TextDirection.rtl,
                        'السعر الكلي: SR ${(product.regularPrice - product.discountPrice).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.03),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor),
                        onPressed: () async {
                          await ProductsService()
                              .addProductToBestSelling(product);
                          Get.defaultDialog(
                            title: product.brand.tr +
                                " Added successfully to BestSelling.",
                          );
                        },
                        child: const Text(
                          textDirection: TextDirection.rtl,
                            style: TextStyle(color: Colors.white),
                            "أضافه الي الأعلي مبيعا")),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () async {
                          await ProductsService()
                              .removeProductFromBestSelling(product);
                          Get.defaultDialog(
                            title: product.brand.tr +
                                " Removed successfully from BestSelling.",
                          );
                        },
                        child: const Text(
                          textDirection: TextDirection.rtl,
                            style: TextStyle(color: Colors.white),
                            "حذف من الأعلي مبيعا")),
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.04),
            StreamBuilder<List<CartItem>>(
                stream: CartService().getCartItemsByProductId(
                    FirebaseAuth.instance.currentUser!.uid, product.id),
                builder: (context, snapshot) {
                  final quantity =
                      (snapshot.data == null || snapshot.data!.isEmpty)
                          ? 0
                          : snapshot.data
                              ?.map((e) => e.quantity)
                              .reduce((value, element) => value + element);
                  final items = snapshot.data;
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        SizedBox(width: Get.width * 0.06),
                        const Text(
                          textDirection: TextDirection.rtl,
                          'أضافه الي عربه التسوق',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        //       await CartService().addToCart(
                        //   FirebaseAuth.instance.currentUser!.uid,
                        //   product,
                        // );
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  CartService().addToCart(
                                    productId: product.id,
                                    userId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    quantity: 1,
                                    productName: product.brand,
                                    image: product.images.first,
                                    price: product.regularPrice,

                                    // product: product,
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  if (items != null) {
                                    CartService().updateCartItemQuantity(
                                        items[0].id, quantity! - 1,quantity);
                                  }
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                )),
                          ],
                        )
                      ],
                    ),
                  );
                })
            // add to cart button
            ,
          ],
        ),
      ),
    );
  }
}
