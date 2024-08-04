import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
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
import 'package:uuid/uuid.dart';

import '../../service/cart_service.dart';
import '../../service/offer_service.dart';
import '../../widgets/shimmer.dart';
import '../drawer_screens/add_category_screen.dart';
import '../drawer_screens/add_products_screen.dart';
import '../drawer_screens/language.dart';
import '../drawer_screens/obout_us.dart';
import '../drawer_screens/technical_support.dart';
import '../drawer_screens/wallet.dart';
import '../my_page_screens/qr_scanner.dart';
import '../search.dart';

class HomePage extends StatefulWidget {
  final String uniqueId;
  const HomePage({Key? key, required this.uniqueId}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<void> _handleSignOut() => _googleSignIn.disconnect();
  int count = 1;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool first = true;
  int _selectedIndex = 0;
   String categoryId = "العطور";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> _saveProfile() async {
    await _firestore.collection('users').doc(widget.uniqueId).set({
      'name': "الأسم",
      'phone': "رقم الهاتف",
      'email' : "البريد الألكتروني",
    });
  }
  @override
  void initState() {
    super.initState();
    _saveProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height*.07),
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
                Get.to( Screen2(uniqueId: widget.uniqueId,));
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
                          .getCartItems(FirebaseAuth.instance.currentUser != null ?
                      FirebaseAuth.instance.currentUser!.uid : widget.uniqueId),
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
            child: Image.asset('images/MYD logotrans.png',
                height: Get.height*.075,
            width: Get.width*.7,
            ),
          ),
          centerTitle: true,
        ),
      ),
      drawer: Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Drawer(
          child: Directionality(
            textDirection: TextDirection.rtl,
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
                    'نقاط حسابك'.tr,
                    style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Get.to(const Wallet());
                  },
                ),
                ListTile(
                  title: Text(
                    'الدعم الفني'.tr,
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
                    'اللغة'.tr,
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
                      'من نحن'.tr,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'موقعنا'.tr,
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
                      'أداره الطلبات'.tr,
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
                      'الأدمن'.tr,
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
                      'أرسال رساله'.tr,
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
                      'اضافه صنف'.tr,
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
                      'اضافه منتج'.tr,
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
                        ' مشاركة التطبيق'.tr,
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
                        title: 'مشاركة التطبيق', text: message, linkUrl: appLink);
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
                                _handleSignOut();
                                Get.offAll(const SignIn());
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
                      'تسجيل الخروج'.tr,
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
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    readOnly: true,
                    onTap: () {
                      Get.to( Search(uniqueId: widget.uniqueId,));
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
                margin: EdgeInsets.only(top: 15,right: 15),
                alignment: Alignment.topRight,
                child: Text('الاصناف',style: TextStyle(fontSize: 19,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,

                ),),
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
                      height: Get.height * 0.07,
                      child: ListView.builder(
                        reverse: true,
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
                height: Get.height * 0.005,
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
                      return buildShimmer();
                    }

                    final products = snapshot.data!;
                    return SizedBox(
                      height: Get.height*.295,
                      width: Get.width,
                      child: GridView.builder(
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                      //  physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.50,
                            crossAxisCount: 1),
                        itemBuilder: (BuildContext context, int index) {
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
                                      Get.to(ProductDetails(product: product, uniqueId: widget.uniqueId,));
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
                                                    // if(FirebaseAuth.instance.currentUser == null){
                                                    //   Get.snackbar("لا يمكن اتمام العمليه", "لأتمام العمليه يجب تسجيل الدخول");
                                                    //   Get.to(const SignIn());
                                                    // }else{
                                                      final result = await CartService()
                                                          .isProductInCart(
                                                          product.id,
                                                          FirebaseAuth
                                                              .instance.currentUser != null ?
                                                          FirebaseAuth.instance.currentUser!.uid : widget.uniqueId);
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
                                                            .instance.currentUser != null ?
                                                        FirebaseAuth.instance.currentUser!.uid : widget.uniqueId, image: product.images.first,
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
                          ),
                    );
                      },
                  ),
              Container(
                margin: EdgeInsets.only(top: 10,right: 15),
                alignment: Alignment.topRight,
                child: Text('الاكثر مبيعا',style: TextStyle(fontSize: 19,
                fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,

                ),),
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
                    return  buildShimmer();
                  }

                  final products = snapshot.data!;
                  return Container(
                    height: Get.height*.195,
                    width: Get.width,
                    child: GridView.builder(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      //  physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.3,
                          crossAxisCount: 1),
                      itemBuilder: (BuildContext context, int index) {
                        final product = products[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
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
                                Get.to(ProductDetails(product: product, uniqueId: widget.uniqueId,));
                              }
                            },
                            child: Container(

                              // height: Get.height * 0.09,
                              // width: Get.width * 0.4,
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
                                    padding: const EdgeInsets.all(4.0),
                                    child: CachedNetworkImage(
                                      imageUrl: product.images.first,
                                     // fit: BoxFit.fill,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            width: Get.width * .4,
                                            height: Get.height * .04,
                                            decoration: BoxDecoration(image: DecorationImage(image: imageProvider )
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Text(
                                      product.brand,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontSize: 8,
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
                                                          fontSize: 10,
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
                                                width: 8,
                                              ),
                                              if (product.discountPrice > 0)
                                                Text(
                                                  (product.regularPrice - product.discountPrice)
                                                      .toString(),
                                                  style:  TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                      color: mainColor),
                                                ),
                                              if (product.discountPrice == 0)
                                                Text(
                                                  product.regularPrice.toString(),
                                                  style:  TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                      color: mainColor),
                                                ),

                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: SizedBox(
                                            width: Get.width * 0.065,
                                            height: Get.height * 0.03,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                // if(FirebaseAuth.instance.currentUser == null){
                                                //   Get.snackbar("لا يمكن اتمام العمليه", "لأتمام العمليه يجب تسجيل الدخول");
                                                //   Get.to(const SignIn());
                                                // }else{
                                                  final result = await CartService()
                                                      .isProductInCart(
                                                      product.id,
                                                      FirebaseAuth.instance.currentUser != null ?FirebaseAuth
                                                          .instance.currentUser!.uid: widget.uniqueId);
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
                                                    userId: FirebaseAuth.instance.currentUser != null ?FirebaseAuth
                                                        .instance.currentUser!.uid : widget.uniqueId, image: product.images.first,
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
                    ),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 10,right: 15),
                alignment: Alignment.topRight,
                child: Text('عناصرك المفضلة',style: TextStyle(fontSize: 19,
                fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,

                ),),
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
                    return buildShimmer();
                  }

                  final products = snapshot.data!;
                  return Container(
                    height: Get.height*.195,
                    width: Get.width,
                    child: GridView.builder(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      //  physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.3,
                          crossAxisCount: 1),
                      itemBuilder: (BuildContext context, int index) {
                        final product = products[index];
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
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
                                    Get.to(ProductDetails(product: product, uniqueId: widget.uniqueId,));
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [

                                    Container(

                                      // height: Get.height * 0.09,
                                      // width: Get.width * 0.4,
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
                                            padding: const EdgeInsets.all(4.0),
                                            child: CachedNetworkImage(
                                              imageUrl: product.images.first,
                                             // fit: BoxFit.fill,
                                              imageBuilder: (context, imageProvider) =>
                                                  Container(
                                                    width: Get.width * .4,
                                                    height: Get.height * .04,
                                                    decoration: BoxDecoration(image: DecorationImage(image: imageProvider )
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
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Text(
                                              product.brand,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  fontSize: 8,
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
                                                                  fontSize: 10,
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
                                                        width: 8,
                                                      ),
                                                      if (product.discountPrice > 0)
                                                        Text(
                                                          (product.regularPrice - product.discountPrice)
                                                              .toString(),
                                                          style:  TextStyle(
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.bold,
                                                              color: mainColor),
                                                        ),
                                                      if (product.discountPrice == 0)
                                                        Text(
                                                          product.regularPrice.toString(),
                                                          style:  TextStyle(
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.bold,
                                                              color: mainColor),
                                                        ),

                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: SizedBox(
                                                    width: Get.width * 0.065,
                                                    height: Get.height * 0.03,
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        // if(FirebaseAuth.instance.currentUser == null){
                                                        //   Get.snackbar("لا يمكن اتمام العمليه", "لأتمام العمليه يجب تسجيل الدخول");
                                                        //   Get.to(const SignIn());
                                                        // }else{
                                                          final result = await CartService()
                                                              .isProductInCart(
                                                              product.id,
                                                              FirebaseAuth.instance.currentUser != null ?FirebaseAuth
                                                                  .instance.currentUser!.uid : widget.uniqueId);
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
                                                            userId: FirebaseAuth.instance.currentUser != null ?FirebaseAuth
                                                                .instance.currentUser!.uid : widget.uniqueId, image: product.images.first,
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

                                  ],
                                ),
                              ),
                            ),
                            Icon(Icons.star,color: Colors.green,),

                          ],
                        );
                      },
                    ),
                  );
                },
              ),
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
