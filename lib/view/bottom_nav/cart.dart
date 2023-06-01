import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../check_out/checkhome.dart';

class Screen2 extends StatefulWidget {
  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  int count = 0;
  List<String> images = [
    'https://cdnprod.mafretailproxy.com/sys-master-root/hc1/hc4/14539671175198/3813_main.jpg_480Wx480H',
    'https://www.citypng.com/public/uploads/preview/cheese-cheetos-crunchy-png-11665747344hyu31dqe6p.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDBhtT8kz4L3ld1y1ZH9fOLv0u8P5rQTAuCA&usqp=CAU',
    'https://s7d1.scene7.com/is/image/mcdonalds/mcdonalds-dasani-water:1-3-product-tile-desktop?wid=829&hei=515&dpr=off',
    'https://ik.imagekit.io/baeimages/catalog/product/cache/b190492e876561b9a9369467f00721c5/6/2/6281031114162-persil-gel-deep-clean-white-flower-3-ltr_vglvitcgz0q8w57m.jpg?tr=w-300',
    'https://cdnprod.mafretailproxy.com/sys-master-root/h81/h0b/11281795612702/17115_1.jpg_480Wx480H',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 100),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(
              height: Get.height * .03,
            );
          },
          itemCount: 6,
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        spreadRadius: 2, blurRadius: 5, color: Colors.grey)
                  ]),
                  child: Image.network(
                    images[index],
                    width: Get.width * .3,
                    height: Get.height * .11,
                  ),
                  margin: EdgeInsets.only(left: 10),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LabTop',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: '25',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                        TextSpan(
                            text: '  SAR',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)),
                      ])),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: Get.width * .25,
                        height: 30,
                        color: Colors.grey.shade300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              child: Icon(Icons.add),
                              onTap: () {
                                setState(() {
                                  count++;
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
                                child: Icon(Icons.remove_outlined))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            );
          },
        ),
      ),
      bottomSheet: BottomSheet(
        elevation: 20,
        onClosing: () {},
        builder: (context) => Container(
          padding: EdgeInsets.only(top: 10),
          width: Get.width,
          height: Get.height * .09,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'TOTAL',
                    style: TextStyle(fontSize: 19, color: Colors.grey),
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: '320',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                    TextSpan(
                        text: '  SAR',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  ])),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.to(CheckHome());
                  },
                  style: ElevatedButton.styleFrom(
                    primary: mainColor,
                    fixedSize: Size(150, 45),
                  ),
                  child: Text(
                    'CHECKOUT',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
