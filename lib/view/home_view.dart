import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:stockat/view/bottom_nav/cart.dart';
import 'package:stockat/view/bottom_nav/screen3.dart';

import 'bottom_nav/screen1.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int index = 0;

  List<Widget> screens = [
    Screen1(),
    Screen2(),
    Screen3(),
  ];

  List<Widget> items = [
    Container(
      width: 300,
      height: 150,
      child: Image.network(
        'https://3orood.net/wp-content/uploads/%D8%B9%D8%B1%D9%88%D8%B6-%D8%B3%D8%B9%D9%88%D8%AF%D9%89-%D9%85%D8%A7%D8%B1%D9%83%D8%AA-%D9%85%D9%86-23-%D9%81%D8%A8%D8%B1%D8%A7%D9%8A%D8%B1-%D8%AD%D8%AA%D9%89-7-%D9%85%D8%A7%D8%B1%D8%B3-2023-%D8%B1%D9%85%D8%B6%D8%A7%D9%86.jpg',
        fit: BoxFit.fill,
      ),
    ),
    Container(
      width: 300,
      height: 150,
      color: Colors.red,
      child: Image.network(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO8P6sdg5y6CfG_0bNhKkX5u5ymocu9xygGQ&usqp=CAU',
        fit: BoxFit.fill,
      ),
    ),
    Container(
      width: 300,
      height: 150,
      color: Colors.red,
      child: Image.network(
        'https://el3rod.com/wp-content/uploads/2023/03/el3rod.com00001-1282-780x470.webp',
        fit: BoxFit.fill,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (val) {
          setState(() {
            index = val;
          });
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'my page'),
        ],
      ),
    );
  }
}
