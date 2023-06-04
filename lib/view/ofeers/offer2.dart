import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Offer2 extends StatefulWidget {
  const Offer2({Key? key}) : super(key: key);

  @override
  State<Offer2> createState() => _Offer2State();
}

class _Offer2State extends State<Offer2> {
  int count = 1;
  double price = 54.25;
  List colors = [
    Colors.red.shade50,
    Colors.teal.shade50,
    Colors.orangeAccent.shade100,
    Colors.blue.shade50,
    Colors.grey.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.),
        backgroundColor: Colors.blue.shade50,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Whole Sale',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * .01,
            ),
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/713/713311.png',
              width: Get.width * .3,
              height: Get.height * .1,
            ),
            const Text(
              'Enjoy discount of up to 4%',
              style: TextStyle(
                  fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Get.height * .005,
            ),
            SizedBox(
              height: Get.height * .7,
              width: Get.width,
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    child: Image.network(
                                        'https://m.media-amazon.com/images/I/41edjmevPHL._AC_UF1000,1000_QL80_.jpg'),
                                    // margin: EdgeInsets.only(right: 10),
                                    color: Colors.white,
                                    width: Get.width * .27,
                                    height: Get.height * .11,
                                  ),
                                  const Text(
                                    'Name',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20, right: 15),
                                child: CircleAvatar(
                                  child: Text(
                                      '${price.toStringAsFixed(2)} \n    SR',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                                  radius: 38,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              Container(
                                width: Get.width * .25,
                                height: 30,
                                color: Colors.grey.shade300,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      child: const Icon(Icons.add),
                                      onTap: () {
                                        setState(() {
                                          count++;
                                          if (count >= 20 && count <= 21) {
                                            price = price - (price * .021);
                                          } else if (count >= 60 &&
                                              count <= 61) {
                                            price = price - (price * .02);
                                          } else if (count >= 100 &&
                                              count <= 101) {
                                            price = price - (price * .0130);
                                          } else if (count >= 120 &&
                                              count <= 121) {
                                            price = price - (price * .0135);
                                          } else {
                                            price = price;
                                          }
                                        });
                                      },
                                    ),
                                    Text('$count'),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            count--;
                                          });
                                        },
                                        child:
                                            const Icon(Icons.remove_outlined))
                                  ],
                                ),
                              )
                            ],
                          ),
                          margin: const EdgeInsets.all(10),
                          width: Get.width,
                          height: Get.height * .17,
                          color: colors[index],
                        ),
                        Positioned(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Row(
                              children: [
                                Text(
                                  'Get',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
                          bottom: 0,
                        ),
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
