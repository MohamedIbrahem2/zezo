import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Canned extends StatefulWidget {
  const Canned({Key? key}) : super(key: key);

  @override
  State<Canned> createState() => _DrinksItemsState();
}

class _DrinksItemsState extends State<Canned> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              setState(() {
                Get.defaultDialog(
                    title: 'search',
                    barrierDismissible: false,
                    middleText: 'Search',
                    content: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ));
              });
            },
          ),
          const Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 15, top: 10),
                child: Icon(
                  Icons.shopping_cart,
                  size: 40,
                  color: Colors.blue,
                ),
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
        backgroundColor: Colors.blue.shade50,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Canned',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: Get.width,
            height: Get.height * .83,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: .8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: 20,
                itemBuilder: (context, index) {
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
                        child: Image.network(
                            'https://media.mapp.sa/452423/conversions/202212271312_93181-preview.png'),
                        width: Get.width * .4,
                        height: Get.height * .14,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'pepsi family 2.25 L *6',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              const Text(
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
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            '20 SR',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                'Get',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.add_shopping_cart,
                                color: Colors.white,
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                        ),
                        width: Get.width * .25,
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
