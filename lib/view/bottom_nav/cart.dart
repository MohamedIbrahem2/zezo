import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/bottom_navbar_provider.dart';
import 'package:stockat/service/cart_service.dart';
import 'package:stockat/view/home_view.dart';

import '../../constants.dart';
import '../check_out/checkhome.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  int count = 0;
  List<String> images = [
    'https://cdnprod.mafretailproxy.com/sys-master-root/hc1/hc4/14539671175198/3813_main.jpg_480Wx480H',
    'https://www.citypng.com/public/uploads/preview/cheese-cheetos-crunchy-png-11665747344hyu31dqe6p.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDBhtT8kz4L3ld1y1ZH9fOLv0u8P5rQTAuCA&usqp=CAU',
    'https://s7d1.scene7.com/is/image/mcdonalds/mcdonalds-dasani-water:1-3-product-tile-desktop?wid=829&hei=515&dpr=off',
    'https://ik.imagekit.io/baeimages/catalog/product/cache/b190492e876561b9a9369467f00721c5/6/2/6281031114162-persil-gel-deep-clean-white-flower-3-ltr_vglvitcgz0q8w57m.jpg?tr=w-300',
    'https://cdnprod.mafretailproxy.com/sys-master-root/h81/h0b/11281795612702/17115_1.jpg_480Wx480H',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child:  Text("Cart",style: TextStyle(color: Colors.white),)),
        backgroundColor: mainColor,
        leading: const BackButton(
          color: Colors.white,

        ),
      ),
      body: Container(
        margin:
        const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 100),
        child: StreamBuilder<List<CartItem>>(
            stream: CartService().getCartItems(
              FirebaseAuth.instance.currentUser!.uid,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final cartItems = snapshot.data!;

              if (cartItems.isEmpty) {
                // no item yet go to home page to shop
                return const Center(
                  child: Text('No items yet, go to home page to shop'),
                );
              }

              return ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: Get.height * .03,
                  );
                },
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];
                  final btn = Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.add),
                        onTap: () {
                          CartService().updateCartItemQuantity(
                              cartItem.id, cartItem.quantity + 1);
                        },
                      ),
                      Text(
                        '${cartItem.quantity}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                          onTap: () {
                            if (cartItem.quantity == 0) {
                              CartService().removeCartItem(cartItem.id);
                              return;
                            }
                            CartService().updateCartItemQuantity(
                                cartItem.id, cartItem.quantity - 1);
                          },
                          child: const Icon(Icons.remove_outlined))
                    ],
                  );
                  return SizedBox(
                    height: 200,
                    child: ListTile(
                      visualDensity:
                      const VisualDensity(vertical: 4, horizontal: 4),
                      leading: CachedNetworkImage(
                        imageUrl: cartItem.image,
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                      title: Text(cartItem.productName),
                      subtitle: Text('${cartItem.price} SAR'),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            child: const Icon(Icons.add),
                            onTap: () {
                              CartService().updateCartItemQuantity(
                                  cartItem.id, cartItem.quantity + 1);
                            },
                          ),
                          Text('${cartItem.quantity}'),
                          InkWell(
                              onTap: () {
                                if (cartItem.quantity == 0) {
                                  CartService().removeCartItem(cartItem.id);
                                  return;
                                }
                                CartService().updateCartItemQuantity(
                                    cartItem.id, cartItem.quantity - 1);
                              },
                              child: const Icon(Icons.remove_outlined))
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
      ),
      bottomSheet: StreamBuilder<List<CartItem>>(
          stream: CartService().getCartItems(
            FirebaseAuth.instance.currentUser!.uid,
          ),
          builder: (context, snapshot) {
            final total = snapshot.data == null || snapshot.data!.isEmpty
                ? 0.0
                : snapshot.data!.fold(0.0, (previousValue, element) {
              return previousValue + (element.price * element.quantity);
            });

            if (total == 0) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: BottomSheet(
                  elevation: 20,
                  onClosing: () {},
                  builder: (context) => InkWell(
                    onTap: () {
                      BottomNavbarProvider.instance(context, listen: false)
                          .changeIndex(0);

                      Get.offAll(const HomeView());
                    },
                    child: Container(

                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(25)),
                      width: Get.width,
                      height: Get.height * .07,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_shopping_cart,color: Colors.white,),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Go To Home To Sop Now',style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            return BottomSheet(
              elevation: 20,
              onClosing: () {},
              builder: (context) => Container(
                padding: const EdgeInsets.only(top: 10),
                width: Get.width,
                height: Get.height * .09,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'TOTAL',
                          style: TextStyle(fontSize: 19, color: Colors.grey),
                        ),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: total.toStringAsFixed(2),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          const TextSpan(
                              text: '  SAR',
                              style:
                              TextStyle(fontSize: 18, color: Colors.black)),
                        ])),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Get.to(const CheckHome());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          fixedSize: const Size(150, 45),
                        ),
                        child: const Text(
                          'CHECKOUT',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            );
          }),
    );
  }
}