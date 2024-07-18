import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:stockat/view/drawer_screens/sendMessage.dart';
import 'package:stockat/view/drawer_screens/unavailable_product.dart';
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
import '../search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 1;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool first = true;
  int _selectedIndex = 0;
   String categoryId = "العطور";
  @override
  void initState() {
    super.initState();
  }

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
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor:mainColor,
          title: Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Image.asset('images/MYD logotrans.png', width: 180, height: 180),
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
                child: Image.asset('images/MYD logo2trans.png'),
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
                    'Send Message'.tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Get.to(const SendMessage());
                  },
                ),
              if (context.watch<AdminProvider>().isAdmin)
                ListTile(
                  title: Text(
                    'Unavailable Product'.tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Get.to(const UnavailableProduct());
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
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * .02,
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
                      borderSide:  BorderSide(
                        width: 3,
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
              SizedBox(
                height: Get.height * .02,
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
                      width: Get.width,
                      height: Get.height * 0.06,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        itemCount: categories!.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return InkWell(
                            onTap:(){
                              setState((){
                                _selectedIndex = index;
                                categoryId = category.name;
                              });

                            },
                            child: Padding(
                              padding:  EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color:  _selectedIndex == index ? mainColor : Colors.grey ,
                                    ),
                                    color: _selectedIndex == index ? mainColor : Colors.grey ,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))
                                ),
                                child:  Center(child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(category.name,
                                    style: const TextStyle(color: Colors.white),
                                    textDirection: TextDirection.rtl,
                                    ),
                                )),
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                      ),
                    );
                  }),
              SizedBox(
                height: Get.height * 0.03,
              ),
              SizedBox(
                height: Get.height * .001,
              ),
              StreamBuilder<List<Product>>(
                  stream: ProductsService().getProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return  Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final products = snapshot.data!;
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.7,
                          crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                            final product = products[index];
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: GestureDetector(
                                onLongPress:() {
                                  final provider = Provider.of<AdminProvider>(context, listen: false);
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

                                },
                                onTap: () {
                                  final provider = Provider.of<AdminProvider>(context, listen: false);
                                    Get.to(ProductDetails(product: product));

                                },
                                child: Container(

                                  height: Get.height * 0.1,
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
                                          fit: BoxFit.fill,
                                          imageBuilder: (context, imageProvider) =>
                                              Container(
                                                width: Get.width * .4,
                                                height: Get.height * .15,
                                                decoration: BoxDecoration(image: DecorationImage(image: imageProvider ,fit: BoxFit.cover)
                                                ),
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          product.brand,
                                          maxLines: 10,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                  Container(
                                                    width: 20,
                                                    height: 1.5,
                                                    color: mainColor,
                                                  )
                                                ],
                                              ),
                                            const SizedBox(
                                              width: 11,
                                            ),
                                            if (product.discountPrice > 0)
                                              Text(
                                                (product.regularPrice - product.discountPrice)
                                                    .toString(),
                                                style:  TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: mainColor),
                                              ),
                                            if (product.discountPrice == 0)
                                              Text(
                                                product.regularPrice.toString(),
                                                style:  TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: mainColor),
                                              ),

                                          ],
                                        ),
                                      ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: Get.width * 0.06,
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
                                                        .instance.currentUser!.uid, image: '',
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
                          },
    );
                      },
                  )
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
            items: [
              {"image": "images/offer_image2.jpg"},
              {"image": "images/offer_image1.jpg"},
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
