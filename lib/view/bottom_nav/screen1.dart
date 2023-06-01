import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/constants.dart';
import 'package:stockat/view/bottom_nav/cart.dart';
import 'package:stockat/view/categories/drinks/drinks_home.dart';
import 'package:stockat/view/categories/flour/flour_home.dart';
import 'package:stockat/view/categories/oil/oil_home.dart';
import 'package:stockat/view/categories/personalcare/personalcare_home.dart';
import 'package:stockat/view/sign_in.dart';
import '../categories/blastic/blastic_home.dart';
import '../categories/canned/canned_home.dart';
import '../categories/crispes/cridpes_home.dart';
import '../categories/foods/foods_home.dart';
import '../drawer_screens/language.dart';
import '../drawer_screens/obout_us.dart';
import '../drawer_screens/offershome.dart';
import '../drawer_screens/technical_support.dart';
import '../drawer_screens/wallet.dart';
import '../ofeers/offer1.dart';
import '../ofeers/offer2.dart';
import '../ofeers/offer3.dart';

class Screen1 extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Widget> items = [
    GestureDetector(
      onTap: () {
        Get.to(Offer1());
      },
      child: Container(
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
        Get.to(Offer2());
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
        Get.to(Offer3());
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
      appBar: AppBar(
        actions: [
          // GestureDetector(
          //   onTap: ()async{
          //     ScanResult result = await BarcodeScanner.scan();
          //     print(result.rawContent);
          //   },
          //     child: Image.asset('logos/barcode.png',width: 30,height: 30,)),
          SizedBox(
            width: 8,
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 10),
                child: GestureDetector(
                    onTap: () {
                      Get.to(Screen2());
                    },
                    child: Icon(
                      Icons.shopping_cart,
                      size: 40,
                      color: Colors.blue,
                    )),
              ),
              Positioned(
                top: 3,
                left: 14,
                child: Text(
                  '3',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text.rich(TextSpan(children: [
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
              child: Text.rich(TextSpan(children: [
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
              title: Text(
                '-wallet',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Get.to(Wallet());
              },
            ),
            ListTile(
              title: Text(
                '-technical support',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Get.to(TechnicalSupport());
              },
            ),
            GestureDetector(
              child: ListTile(
                title: Text(
                  '-offers',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Get.to(OffersHome());
                },
              ),
            ),
            ListTile(
              title: Text(
                '-language',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Get.to(Language());
              },
            ),
            ListTile(
              title: Text(
                '-My account statement',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            GestureDetector(
              onTap: () {
                Get.to(AboutUs());
              },
              child: ListTile(
                title: Text(
                  '-who are we ?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              title: Text(
                '-Our Location',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {},
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
                          child: Text(
                            'No',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white, elevation: 10),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            auth.signOut();
                            Get.to(SignIn());
                          },
                          child: Text('yes',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red, elevation: 10),
                        ),
                      ],
                    ));
              },
              child: ListTile(
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
        child: Container(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * .02,
              ),

              CarouselSlider(
                  items: items,
                  options: CarouselOptions(
                    height: Get.height * .2,
                    aspectRatio: 2,
                    // viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  )),
              SizedBox(
                height: Get.height * .025,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      size: 30,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 1),
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
                  margin: EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
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
              Container(
                height: Get.height * .2,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(DrinksHome());
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 4)
                            ]),
                            margin: EdgeInsets.all(8),
                            child: Image.network(
                              'https://topbazar.nl/wp-content/uploads/2021/04/515Lwr5CyxL-1.jpg',
                              fit: BoxFit.fill,
                            ),
                            width: Get.width * .27,
                            height: Get.height * .13,
                          ),
                          Text(
                            'drinks',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: mainColor),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(FoodsHome());
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 4)
                            ]),
                            margin: EdgeInsets.all(8),
                            child: Image.network(
                              'https://m.media-amazon.com/images/I/61sXm9GDU4L.jpg',
                              fit: BoxFit.fill,
                            ),
                            width: Get.width * .27,
                            height: Get.height * .13,
                          ),
                          Text(
                            'foods',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: mainColor),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(Kafeef());
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 4)
                            ]),
                            margin: EdgeInsets.all(8),
                            child: Image.network(
                              'https://cdnprod.mafretailproxy.com/sys-master-root/hdb/h97/27412118011934/462090_main.jpg_480Wx480H',
                              fit: BoxFit.fill,
                            ),
                            width: Get.width * .27,
                            height: Get.height * .13,
                          ),
                          Text(
                            'Crisps&Khafeef',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: mainColor),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(Oil());
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 4)
                            ]),
                            margin: EdgeInsets.all(8),
                            child: Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoO85i8HxGI1QK0ApMoSGcwtt9-27XifDuiCl1iEPKihEFLfAsZ-cdxBEAnNLx3nZyqrY&usqp=CAU',
                              fit: BoxFit.fill,
                            ),
                            width: Get.width * .27,
                            height: Get.height * .13,
                          ),
                          Text(
                            'Oil',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: mainColor),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(Flour());
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 4)
                            ]),
                            margin: EdgeInsets.all(8),
                            child: Image.network(
                              'https://cdnprod.mafretailproxy.com/sys-master-root/h8f/h45/14596354998302/17530_main.jpg_480Wx480H',
                              fit: BoxFit.fill,
                            ),
                            width: Get.width * .27,
                            height: Get.height * .13,
                          ),
                          Text(
                            'Flour',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: mainColor),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(CannedHome());
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 4)
                                ]),
                            margin: EdgeInsets.all(8),
                            child: Image.network(
                              'https://www.ayambrand.com.my/images/AYAM-product-categories/mackerel.webp',
                              fit: BoxFit.fill,
                            ),
                            width: Get.width * .27,
                            height: Get.height * .13,
                          ),
                          Text(
                            'canned food&sauce',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: mainColor),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(BlasticBaber());
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 4)
                                ]),
                            margin: EdgeInsets.all(8),
                            child: Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFvGXN5oh-twIAWx3yljpFseixof3RhkdyG0YiuAX5vPg9lWVn6GNAdcMOUd7WiQKJpnk&usqp=CAU',
                              fit: BoxFit.fill,
                            ),
                            width: Get.width * .27,
                            height: Get.height * .13,
                          ),
                          Text(
                            ' blastic & paper',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: mainColor),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(PersonalCareHome());
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 4)
                                ]),
                            margin: EdgeInsets.all(8),
                            child: Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR05du0PJOtG8jEtblmcnrUuitA_r8DVbU55THTf2jl6EWXiEgI4V14OsvkAjIbt4qIJ_I&usqp=CAU',
                              fit: BoxFit.fill,
                            ),
                            width: Get.width * .27,
                            height: Get.height * .13,
                          ),
                          Text(
                            'detergents & \npersonal care',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: mainColor),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * .015,
              ),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Best selling',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: Get.height * .001,
              ),
              Container(
                margin: EdgeInsets.all(15),
                width: Get.width,
                height: Get.height * .25,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 1,
                                        blurRadius: 4)
                                  ]),
                              child: Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR05du0PJOtG8jEtblmcnrUuitA_r8DVbU55THTf2jl6EWXiEgI4V14OsvkAjIbt4qIJ_I&usqp=CAU',
                                fit: BoxFit.fill,
                              ),
                              width: Get.width * .3,
                              height: Get.height * .13,
                            ),
                            Text(
                              'product name',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Text(
                                      '25',
                                      style: TextStyle(
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
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  '20 SR',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 20,
                      );
                    },
                    itemCount: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
