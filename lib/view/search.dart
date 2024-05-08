import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/service/product_service.dart';

import '../service/cart_service.dart';
import 'bottom_nav/cart.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchValue = TextEditingController();
  List _resultList = [];
  List _allResult = [];
  @override
  void initState(){
    super.initState();
    _searchValue.addListener(_onSearchChanged);
  }
  _onSearchChanged(){
    searchResultList();
  }
  searchResultList(){
    var showResult = [];
    if(_searchValue.text != ''){
      for(var clientSnapshot in _allResult){
        var name = clientSnapshot['name'].toString().toLowerCase();
        if(name.contains(_searchValue.text.toLowerCase())){
          showResult.add(clientSnapshot);
        }
      }
    }else{
      showResult = List.from(_allResult);
    }
    setState(() {
      _resultList = showResult;
    });
  }
  getClientsStream() async{
    var data = await FirebaseFirestore.instance.collection('products')
        .orderBy('name')
        .get();
    setState(() {
      _allResult = data.docs;
    });
  }
  @override
  void dispose(){
    _searchValue.removeListener(_onSearchChanged);
    _searchValue.dispose();
    super.dispose();
  }
  @override
  void didChangeDependencies(){
    getClientsStream();
    super.didChangeDependencies();
  }
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _searchValue,
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
                  child: StreamBuilder<QuerySnapshot>(
                      stream:  FirebaseFirestore.instance.collection('products')
                                .orderBy('name')
                                .snapshots(),
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
                        if(snapshot.hasData) {
                          final products = snapshot.data!.docs;
                          return GridView.builder(
                              gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                  childAspectRatio: .6,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                              itemCount: _resultList.isEmpty ? products.length : _resultList.length,
                              itemBuilder: (context, index) {
                                print(products.length);
                                var product = products[index].data() as Map<
                                    String,
                                    dynamic>;
                                return Column(
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
                                      child: Image.network(_resultList.isEmpty ? product['image'] : _resultList[index]['image']),
                                      width: Get.width * .4,
                                      height: Get.height * .14,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      _resultList.isEmpty ? product['name'] : _resultList[index]['name'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        if (_resultList.isEmpty ? product['discount'] > 0 : _resultList[index]['discount'] > 0)
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Text(
                                                _resultList.isEmpty ? product['price'].toString() : _resultList[index]['price'].toString(),
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
                                        if (_resultList.isEmpty ? product['discount'] > 0: _resultList[index]['discount'] > 0)
                                          Text(
                                            ((_resultList.isEmpty ? product['price'] : _resultList[index]['price']) -
                                                (_resultList.isEmpty ? product['discount'] : _resultList[index]['discount']))
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green),
                                          ),
                                        if (_resultList.isEmpty ? product['discount'] == 0: _resultList[index]['discount'] == 0)
                                          Text(
                                            (_resultList.isEmpty ? product['price'].toString() : _resultList[index]['price']).toString(),
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
                                            productId: _resultList.isEmpty ? product['id'] : _resultList[index]['id'],
                                            productName: _resultList.isEmpty ? product['name'] : _resultList[index]['name'],
                                            price: _resultList.isEmpty ? product['price'] : _resultList[index]['price'] -
                                                _resultList.isEmpty ? product['discount']: _resultList[index]['discount'],
                                            quantity: 1,
                                            image: _resultList.isEmpty ? product['image'] : _resultList[index]['image'],
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
                                );
                              });
                        }
                          if (!snapshot.hasData) {
                          return const Center(child:CircularProgressIndicator(color: Colors.white,));
                          }
                          return Container();
                          }
                      ),
                )
              ],
            ),
          ),
        ));
  }
}
