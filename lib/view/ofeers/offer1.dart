import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/service/offer_service.dart';

class Offer1 extends StatefulWidget {
  final String offerId;

  const Offer1({
    Key? key,
    required this.offerId,
  }) : super(key: key);

  @override
  State<Offer1> createState() => _Offer1State();
}

class _Offer1State extends State<Offer1> {
  List colors = [
    Colors.red.shade50,
    Colors.teal.shade50,
    Colors.orangeAccent.shade100,
    Colors.blue.shade50,
    Colors.grey.shade100,
  ];
  late Future<List<Package>> future;
  @override
  void initState() {
// get the packages
    final offerService = OfferService();
    future = offerService.getPackagesAndProducts(widget.offerId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        title: const Text(
          'Offer',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<List<Package>>(
          future: future,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              final packages = snapShot.data!;

              return Center(
                child: Container(
                  child: Column(
                    children: [
                      // TextButton(
                      //     onPressed: () => OfferService().createDiscountOffer(
                      //         'offer 3',
                      //         packages[0].products.map((e) => e.id).toList(),
                      //         4,
                      //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO8P6sdg5y6CfG_0bNhKkX5u5ymocu9xygGQ&usqp=CAU'),
                      //     child: const Text('add discount')),
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      Image.network(
                        'https://cdn-icons-png.flaticon.com/512/3620/3620659.png',
                        width: Get.width * .25,
                        height: Get.height * .08,
                      ),
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      const Text(
                        'Enjoy the best discount ! ',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: Get.width,
                        height: Get.height * .705,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              final packages = snapShot.data!;
                              final package = packages[index];
                              final products = package.products;

                              return Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  (Container(
                                    padding: const EdgeInsets.all(12),
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final product = products[index];
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                width: Get.width * .18,
                                                height: Get.height * .1,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          blurRadius: 4,
                                                          spreadRadius: 1,
                                                          color: Colors.grey)
                                                    ]),
                                                child: Image.network(
                                                  product.image,
                                                ),
                                              ),
                                              Text(
                                                product.name,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return Container(
                                              alignment: Alignment.center,
                                              child: const Text('+',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)));
                                        },
                                        itemCount: package.products.length),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    width: Get.width * .9,
                                    height: Get.height * .22,
                                    decoration: BoxDecoration(
                                        color: colors[index],
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                              blurRadius: 5,
                                              spreadRadius: 2,
                                              color: Colors.grey)
                                        ]),
                                  )),
                                  Positioned(
                                    child: Text(
                                      '${package.price} SR',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                    top: 5,
                                  ),
                                  Positioned(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Row(
                                        children: [
                                          Text(
                                            'Get',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 6,
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
                                    bottom: 0,
                                  ),
                                  const Positioned(
                                    bottom: 10,
                                    right: 15,
                                    child: Column(
                                      children: [
                                        Icon(Icons.arrow_forward_outlined),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                            separatorBuilder: (conext, index) {
                              return Container(
                                  margin: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'OR',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ));
                            },
                            itemCount: packages.length),
                      )
                    ],
                  ),
                ),
              );
            }
            if (snapShot.hasError) {
              return Center(
                child: Text(snapShot.error.toString()),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
