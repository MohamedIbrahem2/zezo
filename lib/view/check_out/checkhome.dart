import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/constants.dart';
import 'package:stockat/main.dart';
import 'package:stockat/service/order_service.dart';

import '../../service/address_service.dart';
import '../../service/cart_service.dart';
import '../addresses_pge.dart';

class CheckHome extends StatefulWidget {
  final String unique;
  const CheckHome({Key? key, required this.unique}) : super(key: key);

  @override
  State<CheckHome> createState() => _CheckHomeState();
}

class _CheckHomeState extends State<CheckHome> {
  DateTime now = DateTime.now();
  DateTime finalDate = DateTime.now();
  final addressController = TextEditingController();
  final dateController = TextEditingController();
  List<TextEditingController> phoneNumbersController = [
    TextEditingController()
  ];
  UserProfile? userProfile;
  @override
  void initState() {
    AuthService()
        .getUserProfile(FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      userProfile = value;
      phoneNumbersController[0].text = userProfile!.phone ?? '';
      setState(() {});
    });
    super.initState();
  }

  getCurrentDate() {
    var date = DateTime.now().add(const Duration(days: 1)).toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}/${dateParse.month}/${dateParse.year}";

    // setState(() {
    //   finalDate = formattedDate.toString();
    // });
  }

  String formatDate(DateTime date) => date.toString().substring(0, 10);
  List days = [
    'Saturday',
    'Sunday',
    'Monday',
    'tuesday',
    'wednesday',
    'thursday',
  ];
  List date = [
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
  ];
//

  double count = 1.0;
  Future<void> _selectDate(BuildContext context) async {
    // all dayes except friday

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        finalDate = picked;
        dateController.text = formatDate(finalDate);
        finalDate.toString();
      });
    }
  }

  final AddressService _addressService = AddressService(
    FirebaseAuth.instance.currentUser!.uid,
  );
  Address? selectedAddress;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CartItem>>(
        stream: CartService().getCartItems(FirebaseAuth
            .instance.currentUser!.uid
            .toString()), // Replace 'userId' with the actual user ID
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final cartItems = snapshot.data!;
            int totalQuantity = 0;
            double totalPrice = 0;

            // Calculate total quantity and price
            for (var item in cartItems) {
              totalQuantity += item.quantity;
              totalPrice += item.price * item.quantity;
            }

            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: mainColor,
                iconTheme:  const IconThemeData(color: Colors.white),
                title: const Text(
                  textDirection: TextDirection.rtl,
                  'الدفع',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                       SizedBox(
                        height: Get.height * .03,
                      ),
                      // cart items
                      SizedBox(
                        height: Get.height  * .16,
                        child: StreamBuilder<List<CartItem>>(
                            stream: CartService().getCartItems(
                                FirebaseAuth.instance.currentUser!.uid),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Center(
                                  child: Text('حدث خطأ ما',textDirection: TextDirection.rtl,),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapshot.data!.isEmpty) {
                                return const Center(
                                  child: Text('لا يوجد منتجات في عربة التسوق',textDirection: TextDirection.rtl,),
                                );
                              }
                              final quantity = (snapshot.data == null ||
                                      snapshot.data!.isEmpty)
                                  ? 0
                                  : snapshot.data
                                      ?.map((e) => e.quantity)
                                      .reduce(
                                          (value, element) => value + element);

                              final total = (snapshot.data == null ||
                                      snapshot.data!.isEmpty)
                                  ? 0
                                  : snapshot.data?.map((e) => e.price).reduce(
                                      (value, element) => value + element);

                              return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final item = snapshot.data![index];
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                  )
                                                ]),
                                            child: Image.network(item.image),
                                            margin:
                                                const EdgeInsets.only(right: 7),
                                            width: Get.width * .27,
                                            height: Get.height * .12,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: Get.width * .3,
                                                child: AutoSizeText(
                                                  item.productName,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                (item.quantity * item.price)
                                                        .toString() +
                                                    ' SR',
                                                style:  TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: mainColor),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 50),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    CartService()
                                                        .removeCartItem(
                                                            item.id);
                                                  },
                                                  child:  Icon(
                                                    Icons.delete,
                                                    color: mainColor,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: Get.width * .25,
                                                height: 30,
                                                color: Colors.grey.shade300,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      child:
                                                          const Icon(Icons.add),
                                                      onTap: () {
                                                        CartService()
                                                            .updateCartItemQuantity(
                                                                item.id,
                                                                item.quantity +
                                                                    1,item.quantity);
                                                      },
                                                    ),
                                                    Text(item.quantity
                                                        .toString()),
                                                    GestureDetector(
                                                        onTap: () {
                                                          if (item.quantity ==
                                                              0) {
                                                            CartService()
                                                                .removeCartItem(
                                                                    item.id);
                                                            return;
                                                          }
                                                          CartService()
                                                              .updateCartItemQuantity(
                                                                  item.id,
                                                                  item.quantity -
                                                                      1,item.quantity);
                                                        },
                                                        child: const Icon(Icons
                                                            .remove_outlined))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      width: Get.width * .95,
                                      height: Get.height * .2,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                            )
                                          ]),
                                    );
                                  });
                            }),
                      ),

                      Container(
                        margin: const EdgeInsets.only(left: 15, top: 30),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (userProfile != null)
                              Text(
                                userProfile!.name ?? '',
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            SizedBox(
                              width: Get.width * .04,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                textDirection: TextDirection.rtl,
                                'الأسم :',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(left: 15, top: 30),
                          alignment: Alignment.centerRight,
                          child: const Text(
                            textDirection: TextDirection.rtl,
                            'توصيل الي',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20),
                            width: Get.width * .6,
                            child: StreamBuilder<List<Address>>(
                                stream: _addressService.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.data != null &&
                                      snapshot.data!.isEmpty) {
                                    return Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color:
                                                mainColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Row(
                                          children: [

                                            GestureDetector(
                                              onTap: () {
                                                Get.to(AddressesPage(uniqueId: widget.unique,));
                                              },
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                            ),
                                             SizedBox(
                                              width:Get.width * .04,
                                            ),
                                            const Text(
                                              textDirection: TextDirection.rtl,
                                              'لا يوجد عنوان, قم بأضافه عنوان',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),

                                          ],
                                        ));
                                  }
                                  return DropdownButtonFormField<Address?>(
                                    validator: (value) {
                                      if (selectedAddress == null ||
                                          addressController.text.isEmpty) {
                                        return 'اختار العنوان';
                                      }
                                      return null;
                                    },
                                    value: selectedAddress,
                                    items: snapshot.data == null
                                        ? []
                                        : [
                                            ...snapshot.data!
                                                .map((e) =>
                                                    DropdownMenuItem<Address?>(
                                                      value: e,
                                                      child: Text(e.city),
                                                    ))
                                                .toList()
                                          ],
                                    onChanged: (value) {
                                      selectedAddress = value;
                                      addressController.text =
                                          selectedAddress!.id ?? '';
                                    },
                                    // controller: addressController,
                                    decoration: const InputDecoration(
                                      labelText: 'ادخل العنوان',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                      // GestureDetector(
                      //   onTap: () {

                      //   },
                      //   child: Container(
                      //     margin: const EdgeInsets.only(top: 20),
                      //     decoration: BoxDecoration(
                      //         color: Colors.greenAccent,
                      //         borderRadius: BorderRadius.circular(10),
                      //         boxShadow: const [
                      //           BoxShadow(
                      //             color: Colors.grey,
                      //             spreadRadius: 1,
                      //             blurRadius: 3,
                      //           )
                      //         ]),
                      //     width: Get.width * .87,
                      //     height: 45,
                      //     child: const Text(
                      //       'Add Adress',
                      //       style: TextStyle(
                      //           fontSize: 20,
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.white),
                      //     ),
                      //     alignment: Alignment.center,
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(left: 15, top: 30),
                          alignment: Alignment.centerRight,
                          child: const Text(
                            textDirection: TextDirection.rtl,
                            'اختار موعد التوصيل',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20),
                            width: Get.width * .6,
                            child: TextFormField(
                                readOnly: true,
                                controller: dateController,
                                onTap: () {
                                  _selectDate(context);
                                },
                                decoration: const InputDecoration(
                                  labelText: 'اختار الموعد',
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(left: 15, top: 30),
                          alignment: Alignment.centerRight,
                          child: const Text(
                            textDirection: TextDirection.rtl,
                            'أرقام الهاتف',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      for (var i in phoneNumbersController)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: Get.width * .6,
                              child: TextFormField(
                                  controller: i,
                                  decoration: const InputDecoration(
                                    labelText: 'رقم الهاتف',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                phoneNumbersController
                                    .add(TextEditingController());
                                setState(() {});
                              },
                              icon:  Icon(
                                Icons.add,
                                color: mainColor,
                              )),
                        ],
                      ),
                      // SizedBox(
                      //   width: Get.width,
                      //   height: Get.height * .15,
                      //   child: ListView.builder(
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount: 6,
                      //       itemBuilder: (context, index) {
                      //         return Container(
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //             children: [
                      //               Text(
                      //                 days[index],
                      //                 style: const TextStyle(
                      //                   fontSize: 19,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //               ),
                      //               const Text(
                      //                 '10-12-2023',
                      //                 style: TextStyle(
                      //                   fontSize: 19,
                      //                   color: Colors.grey,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //           margin: const EdgeInsets.all(15),
                      //           width: Get.width * .4,
                      //           height: Get.height * .11,
                      //           decoration: BoxDecoration(
                      //               color: Colors.grey.shade100,
                      //               boxShadow: const [
                      //                 BoxShadow(
                      //                     spreadRadius: .4,
                      //                     blurRadius: 2,
                      //                     color: Colors.black),
                      //               ],
                      //               borderRadius: BorderRadius.circular(5)),
                      //         );
                      //       }),
                      // ),
                      // Container(
                      //   margin: const EdgeInsets.only(left: 15, top: 20),
                      //   alignment: Alignment.centerLeft,
                      //   child: const Text(
                      //     'View available coupon',
                      //     style: TextStyle(
                      //         fontSize: 18.0,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.black),
                      //   ),
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Container(
                      //       margin: const EdgeInsets.all(20),
                      //       width: Get.width * .6,
                      //       child: TextFormField(
                      //         decoration: InputDecoration(
                      //             hintText: 'Enter Coupon code',
                      //             enabledBorder: OutlineInputBorder(
                      //                 borderRadius: BorderRadius.circular(10))),
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(right: 20),
                      //       child: ElevatedButton(
                      //           onPressed: () {},
                      //           style: ElevatedButton.styleFrom(
                      //               backgroundColor: Colors.greenAccent),
                      //           child: const Text('Apply')),
                      //     )
                      //   ],
                      // ),
                      StreamBuilder<List<CartItem>>(
                        stream: CartService().getCartItems(FirebaseAuth
                            .instance.currentUser!.uid
                            .toString()), // Replace 'userId' with the actual user ID
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final cartItems = snapshot.data!;
                            int totalQuantity = 0;
                            double totalPrice = 0;

                            // Calculate total quantity and price
                            for (var item in cartItems) {
                              totalQuantity += item.quantity;
                              totalPrice += item.price * item.quantity;
                            }

                            return Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(15),
                              width: Get.width * .9,
                              height: Get.height * .26,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                boxShadow: const [
                                  BoxShadow(
                                    spreadRadius: .4,
                                    blurRadius: 2,
                                    color: Colors.black,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        textDirection: TextDirection.rtl,
                                        '$totalQuantityقطع',
                                        style:  TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      const Text(
                                        textDirection: TextDirection.rtl,
                                        'المنتجات',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [

                                      Text(
                                        textDirection: TextDirection.rtl,
                                        '$totalPrice SR',
                                        style:  TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      const Text(
                                        textDirection: TextDirection.rtl,
                                        'المجموع',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,

                                        ),
                                      ),
                                    ],
                                  ),
                                  // Add additional rows for other details
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [

                                      Text(
                                        textDirection: TextDirection.rtl,
                                        '${(totalPrice * .15).toStringAsFixed(1)} SR',
                                        style:  TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      const Text(
                                        textDirection: TextDirection.rtl,
                                        'خدمه 15%',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,

                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [

                                       Text(
                                        textDirection: TextDirection.rtl,
                                        '0 SR',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      const Text(
                                        textDirection: TextDirection.rtl,
                                        'تخفيض',
                                        style: TextStyle(
                                          fontSize: 16,

                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [

                                       Text(
                                        textDirection: TextDirection.rtl,
                                        '0 SR',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                       const Text(
                                        textDirection: TextDirection.rtl,
                                        'توصيل',
                                        style: TextStyle(
                                          fontSize: 16,

                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [

                                      Text(
                                        textDirection: TextDirection.rtl,
                                        (totalPrice + (totalPrice * .15))
                                                .toString() +
                                            ' SR',
                                        style:  TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      const Text(
                                        textDirection: TextDirection.rtl,
                                        'المجموع بالخدمه',
                                        style: TextStyle(
                                          fontSize: 16,

                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      )
                      // Container(
                      //   padding: const EdgeInsets.all(10),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             'items',
                      //             style: TextStyle(
                      //                 fontSize: 18, color: Colors.grey.shade800),
                      //           ),
                      //           const Text(
                      //             '10 pieces',
                      //             style: TextStyle(
                      //                 fontSize: 19,
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.black),
                      //           )
                      //         ],
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             'Total',
                      //             style: TextStyle(
                      //                 fontSize: 18, color: Colors.grey.shade800),
                      //           ),
                      //           const Text(
                      //             '200 SR',
                      //             style: TextStyle(
                      //                 fontSize: 19,
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.black),
                      //           )
                      //         ],
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             'Vat 15%',
                      //             style: TextStyle(
                      //                 fontSize: 18, color: Colors.grey.shade800),
                      //           ),
                      //           const Text(
                      //             '30 SR',
                      //             style: TextStyle(
                      //                 fontSize: 19,
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.black),
                      //           )
                      //         ],
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             'discount',
                      //             style: TextStyle(
                      //                 fontSize: 18, color: Colors.grey.shade800),
                      //           ),
                      //           const Text(
                      //             '0 SR',
                      //             style: TextStyle(
                      //                 fontSize: 19,
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.black),
                      //           )
                      //         ],
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             'delivery',
                      //             style: TextStyle(
                      //                 fontSize: 18, color: Colors.grey.shade800),
                      //           ),
                      //           const Text(
                      //             '0 SR',
                      //             style: TextStyle(
                      //                 fontSize: 19,
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.black),
                      //           )
                      //         ],
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             'Total with vat',
                      //             style: TextStyle(
                      //                 fontSize: 18, color: Colors.grey.shade800),
                      //           ),
                      //           const Text(
                      //             '230 SR',
                      //             style: TextStyle(
                      //                 fontSize: 19,
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.black),
                      //           )
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      //   margin: const EdgeInsets.all(15),
                      //   width: Get.width * .9,
                      //   height: Get.height * .25,
                      //   decoration: BoxDecoration(
                      //       color: Colors.grey.shade50,
                      //       boxShadow: const [
                      //         BoxShadow(
                      //             spreadRadius: .4, blurRadius: 2, color: Colors.black),
                      //       ],
                      //       borderRadius: BorderRadius.circular(5)),
                      // ),
                      ,
                       SizedBox(
                        height: Get.height * .1,
                      )
                    ],
                  ),
                ),
              ),
              bottomSheet: BottomSheet(
                onClosing: () {},
                builder: (context) => GestureDetector(
                  onTap: () {
                    // if (totalPrice < 250) {
                    //   Get.snackbar(
                    //     '',
                    //     'أقل حد للطلب هو 250 SAR',
                    //     duration: const Duration(seconds: 2),
                    //     snackPosition: SnackPosition.TOP,
                    //     titleText: const Text(
                    //       textDirection: TextDirection.rtl,
                    //       'لا يمكن اتمام الطلب',
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.w500),
                    //     ),
                    //     messageText: const Text(
                    //       textDirection: TextDirection.rtl,
                    //       'أقل حد للطلب هو 250 SAR',
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //     backgroundColor: mainColor,
                    //   );
                    //   return;
                    // }

                    Get.defaultDialog(
                        title: 'هل تريد تاكيد الطلب ؟',
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    backgroundColor: mainColor),
                                onPressed: () async {
                                  await OrderService().placeOrder(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      cartItems,
                                      totalPrice,
                                      // addressController.text,
                                      selectedAddress!,
                                      finalDate,
                                      phoneNumbersController
                                          .map((e) => e.text)
                                          .where(
                                              (element) => element.isNotEmpty)
                                          .toList());
                                },
                                child: const Text(
                                  textDirection: TextDirection.rtl,
                                  'نعم',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18),
                                )),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    backgroundColor: Colors.white),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  textDirection: TextDirection.rtl,
                                  'ألغاء',
                                  style: TextStyle(color: Colors.black),
                                ))
                          ],
                        ));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: Get.width,
                    height: 50,
                    color: mainColor,
                    child: const Text(
                      textDirection: TextDirection.rtl,
                      'دفع',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
