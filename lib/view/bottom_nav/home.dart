import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stockat/constants.dart';
import 'package:stockat/main.dart';
import 'package:stockat/service/category_service.dart';
import 'package:stockat/service/product_service.dart';
import 'package:stockat/view/bottom_nav/admins.dart';
import 'package:stockat/view/bottom_nav/cart.dart';
import 'package:stockat/view/bottom_nav/peoduct_details.dart';
import 'package:stockat/view/categories/drinks/drinks_home.dart';
import 'package:stockat/view/drawer_screens/add_subcategory_screen.dart';
import 'package:stockat/view/my_page_screens/orders_management.dart';
import 'package:stockat/view/my_page_screens/our_location_page.dart';
import 'package:stockat/view/sign_in.dart';

import '../../service/cart_service.dart';
import '../../service/offer_service.dart';
import '../drawer_screens/add_category_screen.dart';
import '../drawer_screens/add_products_screen.dart';
import '../drawer_screens/language.dart';
import '../drawer_screens/obout_us.dart';
import '../drawer_screens/technical_support.dart';
import '../drawer_screens/wallet.dart';
import '../my_page_screens/qr_scanner.dart';
import '../ofeers/offer1.dart';
import '../ofeers/offer2.dart';
import '../ofeers/offer3.dart';
import '../search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30)
            )
          ),
          actions: [
            GestureDetector(
                onTap: () async {
                  Get.to(const QrView());
                  // ScanResult result = await BarcodeScanner.scan();
                  // print(result.rawContent);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.asset(
                    'logos/barcode.png',
                    width: 30,
                    height: 30,
                  ),
                )),
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
                      Icons.shopping_cart_outlined,
                      size: 40,
                      color: Colors.black,
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
                            width: 20,
                            height: 20,
                            child: Center(
                              child: Text(
                                snapshot.data == null ? '0' : quantity.toString(),
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
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.greenAccent,
          title: Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Image.asset('images/logo2.png', width: 100, height: 100),
          ),
          centerTitle: true,
        ),
      ),
      drawer: Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(30),
                child: Image.asset('images/logo2.png'),
                width: Get.width,
                height: Get.height * .2,
                alignment: Alignment.center,
                color: Colors.blue.shade50,
              ),
              ListTile(
                title: Text(
                  'wallet'.tr,
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Get.to(const Wallet());
                },
              ),
              ListTile(
                title: Text(
                  'technical_support'.tr,
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Get.to(const TechnicalSupport());
                },
              ),
              // GestureDetector(
              //   child: ListTile(
              //     title: Text(
              //       'offers'.tr,
              //       style: const TextStyle(
              //           fontSize: 18, fontWeight: FontWeight.bold),
              //     ),
              //     onTap: () {
              //       Get.to(const OffersHome());
              //     },
              //   ),
              // ),
              // GestureDetector(
              //   child: ListTile(
              //     title: Text(
              //       'profile'.tr,
              //       style: const TextStyle(
              //           fontSize: 18, fontWeight: FontWeight.bold),
              //     ),
              //     onTap: () {
              //       Get.to(const PrfileScreen());
              //     },
              //   ),
              // ),
              ListTile(
                title: Text(
                  'language'.tr,
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Get.to(const Language());
                },
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const AboutUs());
                },
                child: ListTile(
                  title: Text(
                    'who_we_are'.tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'our_location'.tr,
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Get.to(const OurLocationPage());
                },
              ),
              if (context.watch<AdminProvider>().isAdmin)
                ListTile(
                  title: Text(
                    'orders Management'.tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Get.to(const OrdersManagement());
                  },
                ),
              if (context.watch<AdminProvider>().isAdmin)
                ListTile(
                  title: Text(
                    'admins'.tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Get.to(const AdminsPage());
                  },
                ),
              if (context.watch<AdminProvider>().isAdmin)
                ListTile(
                  title: Text(
                    'add category'.tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Get.to(const AddCategoryScreen());
                  },
                ),
              if (context.watch<AdminProvider>().isAdmin)
                ListTile(
                  title: Text(
                    'add subcategory'.tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Get.to(const AddSubCategoryScreen());
                  },
                ),
              if (context.watch<AdminProvider>().isAdmin)
                ListTile(
                  title: Text(
                    'add product'.tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Get.to(const AddProductScreen());
                  },
                ),
              ListTile(
                title: Row(
                  children: [
                    Text(
                      'share app'.tr,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.share,
                      color: Colors.black,
                    )
                  ],
                ),
                onTap: () async {
                  // Set the app link and the message to be shared
                  const String appLink =
                      'https://play.google.com/store/apps/details?id=com.example.myapp';
                  const String message = 'Share our app with others: $appLink';

                  // Share the app link and message using the share dialog
                  await FlutterShare.share(
                      title: 'Share App', text: message, linkUrl: appLink);
                },
              ),
              GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                      title: 'Are you sure?'.tr,
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'no'.tr,
                              style: const TextStyle(color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white, elevation: 10),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              auth.signOut();
                              Get.to(const SignIn());
                            },
                            child: Text('yes'.tr,
                                style: const TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red, elevation: 10),
                          ),
                        ],
                      ));
                },
                child: ListTile(
                  title: Text(
                    'logout'.tr,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Expanded(
        child: SingleChildScrollView(
          child: SizedBox(
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * .02,
                ),
                const OfferCarousel(),
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
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                        size: 30,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 1),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 3,
                          color: Colors.green
                        ),
                          borderRadius: BorderRadius.circular(25)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3,
                              color: Colors.green
                          ),

                          borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * .04,
                ),
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    alignment: Get.locale == const Locale('ar')
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: Text(
                      'categories'.tr,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: Get.height * .001,
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
                      return SizedBox(
                        height: 320,
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 2.0),
                          itemCount: categories!.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(SubCategoriesScreen(
                                      categoryId: category.id,
                                    ));
                                  },
                                  child:
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CachedNetworkImage(
                                              imageUrl: category.image,
                                              fit: BoxFit.fill,
                                              imageBuilder: (context, imageProvider) =>
                                              Container(
                                                width: Get.width * .13,
                                                height: Get.height * .13,
                                                decoration: BoxDecoration(
                                                   boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius: 4
                                                    )
                                                  ],
                                                  border: Border.all(
                                                    width: 3,
                                                    color: Colors.green
                                                  ),
                                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                  image: DecorationImage(image: imageProvider ,fit: BoxFit.cover)
                                                ),
                                              ),
                                            ),
                                          ),
                                          /*Text(
                                            category.name,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )

                                           */

                                ),
                              ],
                            );
                          },
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 5,
                            crossAxisCount: 4),
                        ),
                      );
                    }),
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    alignment: Get.locale!.languageCode == 'ar'
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: Text(
                      'best_selling'.tr,
                      style: const TextStyle(
                          fontSize: 21, fontWeight: FontWeight.bold),
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CachedNetworkImage(
                                          imageUrl: product.image,
                                          fit: BoxFit.fill,
                                          imageBuilder: (context, imageProvider) =>
                                              Container(
                                                width: Get.width * .3,
                                                height: Get.height * .13,
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey,
                                                          blurRadius: 4
                                                      )
                                                    ],
                                                    border: Border.all(
                                                        width: 3,
                                                        color: Colors.green
                                                    ),
                                                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                    image: DecorationImage(image: imageProvider ,fit: BoxFit.cover)
                                                ),
                                              ),
                                        ),
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
                                            width: 11,
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
            items: [
              {"image": "images/offer_image2.jpeg"},
              {"image": "images/offer_image1.jpeg"},
            ].map((offer) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      // if (offer.type == 'package') {
                      //   Get.to(() => Offer1(
                      //         offerId: offer.id,
                      //       ));
                      // }
                      // if (offer.type == 'discount') {
                      //   Get.to(() => Offer2(
                      //         offer: offer,
                      //       ));
                      // }
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
                          image: AssetImage(offer['image'] as String),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 130,
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
