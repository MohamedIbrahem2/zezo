import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(product.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          const SizedBox(width: 8),

                          // qr code button

                          IconButton(
                              onPressed: () {
                                Get.to(ProductQrImageView(
                                    id: product.id, productName: product.name));
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
                        product.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Price: SR ${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Discount: ${product.discount}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 8),
                      // total price
                      Text(
                        'Total Price: SR ${(product.price - product.discount).toStringAsFixed(2)}',
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
            const SizedBox(
              height: 70,
            ),
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
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Add to Cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
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
                                    productName: product.name,
                                    image: product.image,
                                    price: product.price,

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
                                        items[0].id, quantity! - 1);
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
