import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/constants.dart';
import 'package:stockat/service/category_service.dart';
import 'package:stockat/service/product_service.dart';
import 'package:stockat/view/bottom_nav/cart.dart';
import 'package:stockat/view/bottom_nav/peoduct_details.dart';
import 'package:stockat/view/categories/drinks/drinks_home.dart';
import 'package:stockat/view/drawer_screens/add_subcategory_screen.dart';
import 'package:stockat/view/sign_in.dart';

import '../../service/cart_service.dart';
import '../../service/offer_service.dart';
import '../drawer_screens/add_category_screen.dart';
import '../drawer_screens/add_products_screen.dart';
import '../drawer_screens/language.dart';
import '../drawer_screens/obout_us.dart';
import '../drawer_screens/offershome.dart';
import '../drawer_screens/prfile_screen.dart';
import '../drawer_screens/technical_support.dart';
import '../drawer_screens/wallet.dart';
import '../ofeers/offer1.dart';
import '../ofeers/offer2.dart';
import '../ofeers/offer3.dart';
import '../search.dart';

class Screen1 extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Widget> items = [
    GestureDetector(
      onTap: () {
        Get.to(const Offer1(
          offerId: '',
        ));
      },
      child: SizedBox(
        width: 300,
        height: 150,
        child: Image.network(
          'https://3orood.net/wp-content/uploads/%D8%B9%D8%B1%D9%88%D8%B6-%D8%B3%D8%B9%D9%88%D8%AF%D9%89-%D9%85%D8%A7%D8%B1%D9%83%D8%AA-%D9%85%D9%86-23-%D9%81%D8%A8%D8%B1%D8%A7%D9%8A%D8%B1-%D8%AD%D8%AA%D9%89-7-%D9%85%D8%A7%D8%B1%D8%B3-2023-%D8%B1%D9%85%D8%B6%D8%A7%D9%86.jpg',
          fit: BoxFit.fill,
        ),
      ),
    ),
    GestureDetector(
      onTap: () {
        Get.to(const Offer2());
      },
      child: Container(
        width: 300,
        height: 150,
        color: Colors.red,
        child: Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO8P6sdg5y6CfG_0bNhKkX5u5ymocu9xygGQ&usqp=CAU',
          fit: BoxFit.fill,
        ),
      ),
    ),
    GestureDetector(
      onTap: () {
        Get.to(const Offer3());
      },
      child: Container(
        width: 300,
        height: 150,
        color: Colors.red,
        child: Image.network(
          'https://el3rod.com/wp-content/uploads/2023/03/el3rod.com00001-1282-780x470.webp',
          fit: BoxFit.fill,
        ),
      ),
    ),
  ];

  Screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // GestureDetector(
          //   onTap: ()async{
          //     ScanResult result = await BarcodeScanner.scan();
          //     print(result.rawContent);
          //   },
          //     child: Image.asset('logos/barcode.png',width: 30,height: 30,)),
          const SizedBox(
            width: 8,
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
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text.rich(TextSpan(children: [
          TextSpan(
              text: 'S',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple)),
          TextSpan(
              text: 't',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
          TextSpan(
              text: 'o',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
          TextSpan(
              text: 'ck',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
          TextSpan(
              text: 'A',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple)),
          TextSpan(
              text: 'T',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple)),
        ])),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              child: const Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'S',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple)),
                TextSpan(
                    text: 't',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
                TextSpan(
                    text: 'o',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
                TextSpan(
                    text: 'ck',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
                TextSpan(
                    text: 'A',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple)),
                TextSpan(
                    text: 'T',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple)),
              ])),
              width: Get.width,
              height: Get.height * .2,
              alignment: Alignment.center,
              color: Colors.blue.shade50,
            ),
            ListTile(
              title: const Text(
                '-wallet',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Get.to(const Wallet());
              },
            ),
            ListTile(
              title: const Text(
                '-technical support',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Get.to(const TechnicalSupport());
              },
            ),
            GestureDetector(
              child: ListTile(
                title: const Text(
                  '-offers',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Get.to(const OffersHome());
                },
              ),
            ),
            GestureDetector(
              child: ListTile(
                title: const Text(
                  'profile',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Get.to(const PrfileScreen());
                },
              ),
            ),
            ListTile(
              title: const Text(
                '-language',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Get.to(const Language());
              },
            ),
            ListTile(
              title: const Text(
                '-My account statement',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            GestureDetector(
              onTap: () {
                Get.to(const AboutUs());
              },
              child: const ListTile(
                title: Text(
                  '-who are we ?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                '-Our Location',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Add Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Get.to(const AddCategoryScreen());
              },
            ),
            ListTile(
              title: const Text(
                'Add SubCategory',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Get.to(const AddSubCategoryScreen());
              },
            ),
            ListTile(
              title: const Text(
                'Add Product',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Get.to(const AddProductScreen());
              },
            ),
            GestureDetector(
              onTap: () {
                Get.defaultDialog(
                    title: 'Are you sure?',
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, elevation: 10),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            auth.signOut();
                            Get.to(const SignIn());
                          },
                          child: const Text('yes',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red, elevation: 10),
                        ),
                      ],
                    ));
              },
              child: const ListTile(
                title: Text(
                  '-log out',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * .02,
              ),
              const OfferCarousel(),
              // CarouselSlider(
              //     items: items,
              //     options: CarouselOptions(
              //       height: Get.height * .2,
              //       aspectRatio: 2,
              //       // viewportFraction: 0.8,
              //       initialPage: 0,
              //       enableInfiniteScroll: true,
              //       reverse: false,
              //       autoPlay: true,
              //       autoPlayInterval: const Duration(seconds: 2),
              //       autoPlayAnimationDuration:
              //           const Duration(milliseconds: 800),
              //       autoPlayCurve: Curves.fastOutSlowIn,
              //       enlargeCenterPage: true,
              //       scrollDirection: Axis.horizontal,
              //     )),
              SizedBox(
                height: Get.height * .025,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    Get.to(const Search());
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
              SizedBox(
                height: Get.height * .04,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Categories',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: Get.height * .001,
              ),
              // Container(
              //   margin: EdgeInsets.only(left: 10),
              //   width: Get.width,
              //   height: Get.height*.2,
              //   child: ListView.separated(
              //     separatorBuilder: (context, index){
              //       return SizedBox(width: 15,);
              //     },
              //     scrollDirection: Axis.horizontal,
              //     itemCount: 20,
              //     itemBuilder: (context,index){
              //       return Column(
              //         children: [
              //           CircleAvatar(
              //
              //             child: Image.network('https://cdn-icons-png.flaticon.com/512/862/862819.png',width: Get.width*.131,),
              //             backgroundColor: Colors.white,
              //             radius: 30,
              //
              //           ),
              //           SizedBox(height: 10,),
              //           Text('Men',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
              //         ],
              //       );
              //     },
              //   ),
              // )

              // TextButton(
              //     onPressed: () {
              //       CategoryService().addCategory('drinks',
              //           'https://topbazar.nl/wp-content/uploads/2021/04/515Lwr5CyxL-1.jpg');

              //       CategoryService().addCategory('food',
              //           'https://m.media-amazon.com/images/I/61sXm9GDU4L.jpg');
              //     },
              //     child: const Text('add category')),
              SizedBox(
                height: Get.height * .2,
                child: StreamBuilder<List<Category>>(
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
                      return ListView.builder(
                        itemCount: categories!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(DrinksHome(
                                categoryId: category.id,
                              ));
                            },
                            child: Column(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 1,
                                        blurRadius: 4)
                                  ]),
                                  margin: const EdgeInsets.all(8),
                                  child: Image.network(
                                    category.image,
                                    fit: BoxFit.fill,
                                  ),
                                  width: Get.width * .27,
                                  height: Get.height * .13,
                                ),
                                Text(
                                  category.name,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: mainColor),
                                )
                              ],
                            ),
                          );
                        },

                        // children: [
                        //   GestureDetector(
                        //     onTap: () {
                        //       Get.to(const DrinksHome());
                        //     },
                        //     child: Column(
                        //       children: [
                        //         Container(
                        //           decoration: const BoxDecoration(boxShadow: [
                        //             BoxShadow(
                        //                 color: Colors.grey,
                        //                 spreadRadius: 1,
                        //                 blurRadius: 4)
                        //           ]),
                        //           margin: const EdgeInsets.all(8),
                        //           child: Image.network(
                        //             'https://topbazar.nl/wp-content/uploads/2021/04/515Lwr5CyxL-1.jpg',
                        //             fit: BoxFit.fill,
                        //           ),
                        //           width: Get.width * .27,
                        //           height: Get.height * .13,
                        //         ),
                        //         Text(
                        //           'drinks',
                        //           style: TextStyle(
                        //               fontSize: 14,
                        //               fontWeight: FontWeight.bold,
                        //               color: mainColor),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        //   // GestureDetector(
                        //   //   onTap: () {
                        //   //     Get.to(const DrinksHome());
                        //   //   },
                        //   //   child: Column(
                        //   //     children: [
                        //   //       Container(
                        //   //         decoration: const BoxDecoration(boxShadow: [
                        //   //           BoxShadow(
                        //   //               color: Colors.grey,
                        //   //               spreadRadius: 1,
                        //   //               blurRadius: 4)
                        //   //         ]),
                        //   //         margin: const EdgeInsets.all(8),
                        //   //         child: Image.network(
                        //   //           'https://topbazar.nl/wp-content/uploads/2021/04/515Lwr5CyxL-1.jpg',
                        //   //           fit: BoxFit.fill,
                        //   //         ),
                        //   //         width: Get.width * .27,
                        //   //         height: Get.height * .13,
                        //   //       ),
                        //   //       Text(
                        //   //         'drinks',
                        //   //         style: TextStyle(
                        //   //             fontSize: 14,
                        //   //             fontWeight: FontWeight.bold,
                        //   //             color: mainColor),
                        //   //       )
                        //   //     ],
                        //   //   ),
                        //   // ),
                        //   // GestureDetector(
                        //   //   onTap: () {
                        //   //     Get.to(const FoodsHome());
                        //   //   },
                        //   //   child: Column(
                        //   //     children: [
                        //   //       Container(
                        //   //         decoration: const BoxDecoration(boxShadow: [
                        //   //           BoxShadow(
                        //   //               color: Colors.grey,
                        //   //               spreadRadius: 1,
                        //   //               blurRadius: 4)
                        //   //         ]),
                        //   //         margin: const EdgeInsets.all(8),
                        //   //         child: Image.network(
                        //   //           'https://m.media-amazon.com/images/I/61sXm9GDU4L.jpg',
                        //   //           fit: BoxFit.fill,
                        //   //         ),
                        //   //         width: Get.width * .27,
                        //   //         height: Get.height * .13,
                        //   //       ),
                        //   //       Text(
                        //   //         'foods',
                        //   //         style: TextStyle(
                        //   //             fontSize: 15,
                        //   //             fontWeight: FontWeight.bold,
                        //   //             color: mainColor),
                        //   //       )
                        //   //     ],
                        //   //   ),
                        //   // ),
                        //   // GestureDetector(
                        //   //   onTap: () {
                        //   //     Get.to(const Kafeef());
                        //   //   },
                        //   //   child: Column(
                        //   //     children: [
                        //   //       Container(
                        //   //         decoration: const BoxDecoration(boxShadow: [
                        //   //           BoxShadow(
                        //   //               color: Colors.grey,
                        //   //               spreadRadius: 1,
                        //   //               blurRadius: 4)
                        //   //         ]),
                        //   //         margin: const EdgeInsets.all(8),
                        //   //         child: Image.network(
                        //   //           'https://cdnprod.mafretailproxy.com/sys-master-root/hdb/h97/27412118011934/462090_main.jpg_480Wx480H',
                        //   //           fit: BoxFit.fill,
                        //   //         ),
                        //   //         width: Get.width * .27,
                        //   //         height: Get.height * .13,
                        //   //       ),
                        //   //       Text(
                        //   //         'Crisps&Khafeef',
                        //   //         style: TextStyle(
                        //   //             fontSize: 14,
                        //   //             fontWeight: FontWeight.bold,
                        //   //             color: mainColor),
                        //   //       )
                        //   //     ],
                        //   //   ),
                        //   // ),
                        //   // GestureDetector(
                        //   //   onTap: () {
                        //   //     Get.to(const Oil());
                        //   //   },
                        //   //   child: Column(
                        //   //     children: [
                        //   //       Container(
                        //   //         decoration: const BoxDecoration(boxShadow: [
                        //   //           BoxShadow(
                        //   //               color: Colors.grey,
                        //   //               spreadRadius: 1,
                        //   //               blurRadius: 4)
                        //   //         ]),
                        //   //         margin: const EdgeInsets.all(8),
                        //   //         child: Image.network(
                        //   //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoO85i8HxGI1QK0ApMoSGcwtt9-27XifDuiCl1iEPKihEFLfAsZ-cdxBEAnNLx3nZyqrY&usqp=CAU',
                        //   //           fit: BoxFit.fill,
                        //   //         ),
                        //   //         width: Get.width * .27,
                        //   //         height: Get.height * .13,
                        //   //       ),
                        //   //       Text(
                        //   //         'Oil',
                        //   //         style: TextStyle(
                        //   //             fontSize: 14,
                        //   //             fontWeight: FontWeight.bold,
                        //   //             color: mainColor),
                        //   //       )
                        //   //     ],
                        //   //   ),
                        //   // ),
                        //   // GestureDetector(
                        //   //   onTap: () {
                        //   //     Get.to(const Flour());
                        //   //   },
                        //   //   child: Column(
                        //   //     children: [
                        //   //       Container(
                        //   //         decoration: const BoxDecoration(boxShadow: [
                        //   //           BoxShadow(
                        //   //               color: Colors.grey,
                        //   //               spreadRadius: 1,
                        //   //               blurRadius: 4)
                        //   //         ]),
                        //   //         margin: const EdgeInsets.all(8),
                        //   //         child: Image.network(
                        //   //           'https://cdnprod.mafretailproxy.com/sys-master-root/h8f/h45/14596354998302/17530_main.jpg_480Wx480H',
                        //   //           fit: BoxFit.fill,
                        //   //         ),
                        //   //         width: Get.width * .27,
                        //   //         height: Get.height * .13,
                        //   //       ),
                        //   //       Text(
                        //   //         'Flour',
                        //   //         style: TextStyle(
                        //   //             fontSize: 14,
                        //   //             fontWeight: FontWeight.bold,
                        //   //             color: mainColor),
                        //   //       )
                        //   //     ],
                        //   //   ),
                        //   // ),
                        //   // GestureDetector(
                        //   //   onTap: () {
                        //   //     Get.to(const CannedHome());
                        //   //   },
                        //   //   child: Column(
                        //   //     children: [
                        //   //       Container(
                        //   //         decoration: const BoxDecoration(
                        //   //             color: Colors.white,
                        //   //             boxShadow: [
                        //   //               BoxShadow(
                        //   //                   color: Colors.grey,
                        //   //                   spreadRadius: 1,
                        //   //                   blurRadius: 4)
                        //   //             ]),
                        //   //         margin: const EdgeInsets.all(8),
                        //   //         child: Image.network(
                        //   //           'https://www.ayambrand.com.my/images/AYAM-product-categories/mackerel.webp',
                        //   //           fit: BoxFit.fill,
                        //   //         ),
                        //   //         width: Get.width * .27,
                        //   //         height: Get.height * .13,
                        //   //       ),
                        //   //       Text(
                        //   //         'canned food&sauce',
                        //   //         style: TextStyle(
                        //   //             fontSize: 13,
                        //   //             fontWeight: FontWeight.bold,
                        //   //             color: mainColor),
                        //   //       )
                        //   //     ],
                        //   //   ),
                        //   // ),
                        //   // GestureDetector(
                        //   //   onTap: () {
                        //   //     Get.to(const BlasticBaber());
                        //   //   },
                        //   //   child: Column(
                        //   //     children: [
                        //   //       Container(
                        //   //         decoration: const BoxDecoration(
                        //   //             color: Colors.white,
                        //   //             boxShadow: [
                        //   //               BoxShadow(
                        //   //                   color: Colors.grey,
                        //   //                   spreadRadius: 1,
                        //   //                   blurRadius: 4)
                        //   //             ]),
                        //   //         margin: const EdgeInsets.all(8),
                        //   //         child: Image.network(
                        //   //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFvGXN5oh-twIAWx3yljpFseixof3RhkdyG0YiuAX5vPg9lWVn6GNAdcMOUd7WiQKJpnk&usqp=CAU',
                        //   //           fit: BoxFit.fill,
                        //   //         ),
                        //   //         width: Get.width * .27,
                        //   //         height: Get.height * .13,
                        //   //       ),
                        //   //       Text(
                        //   //         ' blastic & paper',
                        //   //         style: TextStyle(
                        //   //             fontSize: 13,
                        //   //             fontWeight: FontWeight.bold,
                        //   //             color: mainColor),
                        //   //       )
                        //   //     ],
                        //   //   ),
                        //   // ),
                        //   // GestureDetector(
                        //   //   onTap: () {
                        //   //     Get.to(const PersonalCareHome());
                        //   //   },
                        //   //   child: Column(
                        //   //     children: [
                        //   //       Container(
                        //   //         decoration: const BoxDecoration(
                        //   //             color: Colors.white,
                        //   //             boxShadow: [
                        //   //               BoxShadow(
                        //   //                   color: Colors.grey,
                        //   //                   spreadRadius: 1,
                        //   //                   blurRadius: 4)
                        //   //             ]),
                        //   //         margin: const EdgeInsets.all(8),
                        //   //         child: Image.network(
                        //   //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR05du0PJOtG8jEtblmcnrUuitA_r8DVbU55THTf2jl6EWXiEgI4V14OsvkAjIbt4qIJ_I&usqp=CAU',
                        //   //           fit: BoxFit.fill,
                        //   //         ),
                        //   //         width: Get.width * .27,
                        //   //         height: Get.height * .13,
                        //   //       ),
                        //   //       Text(
                        //   //         'detergents & \npersonal care',
                        //   //         style: TextStyle(
                        //   //             fontSize: 13,
                        //   //             fontWeight: FontWeight.bold,
                        //   //             color: mainColor),
                        //   //       )
                        //   //     ],
                        //   //   ),
                        //   // ),
                        // ],
                      );
                    }),
              ),
              SizedBox(
                height: Get.height * .015,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Best selling',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: Get.height * .001,
              ),
              StreamBuilder<List<Product>>(
                  stream: ProductsService().getBestSellingProducts(),
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

                    final products = snapshot.data!;

                    return Container(
                      margin: const EdgeInsets.all(15),
                      width: Get.width * .95,
                      height: Get.height * .30,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return SizedBox(
                              width: Get.width * .3,
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(ProductDetails(product: product));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // TextButton(
                                    //     onPressed: () {
                                    //       final offerService = OfferService();
                                    //       offerService.createPackageOffer(
                                    //           'Offer',
                                    //           [
                                    //             Package(
                                    //               name: 'offer package',
                                    //               price: 2340,
                                    //               productIds: products
                                    //                   .map((e) => e.id)
                                    //                   .toList(),
                                    //             )
                                    //           ],
                                    //           'https://3orood.net/wp-content/uploads/%D8%B9%D8%B1%D9%88%D8%B6-%D8%B3%D8%B9%D9%88%D8%AF%D9%89-%D9%85%D8%A7%D8%B1%D9%83%D8%AA-%D9%85%D9%86-23-%D9%81%D8%A8%D8%B1%D8%A7%D9%8A%D8%B1-%D8%AD%D8%AA%D9%89-7-%D9%85%D8%A7%D8%B1%D8%B3-2023-%D8%B1%D9%85%D8%B6%D8%A7%D9%86.jpg');
                                    //     },
                                    //     child: const Text('add packes offer')),
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 1,
                                                blurRadius: 4)
                                          ]),
                                      child: Image.network(
                                        product.image,
                                        fit: BoxFit.fill,
                                      ),
                                      width: Get.width * .3,
                                      height: Get.height * .13,
                                    ),
                                    Text(
                                      product.name,
                                      maxLines: 10,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                            product.price.toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green),
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 20,
                            );
                          },
                          itemCount: products.length),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class OfferCarousel extends StatelessWidget {
  const OfferCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Offer>>(
      stream: OfferService().getAllOffers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final offers = snapshot.data!;

        return GestureDetector(
          child: CarouselSlider(
            items: offers.map((offer) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      if (offer.type == 'package') {
                        Get.to(() => Offer1(
                              offerId: offer.id,
                            ));
                      }
                      if (offer.type == 'discount') {
                        Get.to(() => Offer2(
                              offer: offer,
                            ));
                      }
                    },
                    child: Container(
                      // width: 200, height: 200,
                      // Customize the layout of each offer item here
                      // width: 200,

                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 4,
                          )
                        ],
                        image: DecorationImage(
                          image: NetworkImage(offer.image),
                          fit: BoxFit.fill,
                        ),
                      ),
                      // child: Column(
                      //   children: [
                      //     Image.network(offer.image, fit: BoxFit.fill),
                      //     // Text(offer.name),
                      //     // Text('Price: \$${offer.price.toStringAsFixed(2)}'),
                      //   ],
                      // ),
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 200,
              aspectRatio: 2.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
        );
      },
    );
  }
}
