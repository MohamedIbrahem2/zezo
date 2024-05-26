import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/main.dart';
import 'package:stockat/view/bottom_nav/cart.dart';
import 'package:stockat/view/bottom_nav/profile.dart';
import 'package:stockat/view_model/auth_view_model.dart';

import '../bottom_navbar_provider.dart';
import 'bottom_nav/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AuthViewModel yourController =
  Get.put(AuthViewModel()..getUserProfile());

  @override
  void initState() {
    AdminProvider().checkIfAdmin();
    super.initState();
  }

  int index = 0;

  List<Widget> screens = [
    HomePage(),
    const Screen2(),
    const Settings(),
  ];

  List<Widget> items = [
    SizedBox(
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
    final bottomNavProvider = BottomNavbarProvider.instance(context);
    return Scaffold(
      body: screens[bottomNavProvider.currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40), topLeft: Radius.circular(40)
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,spreadRadius: 0,blurRadius: 5
              )
            ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)
          ),
          child: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.green.shade300,
            onTap: (val) {
              bottomNavProvider.changeIndex(val);
            },
            currentIndex: bottomNavProvider.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home), label: 'home'.tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.shopping_cart), label: 'cart'.tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.person), label: 'my_page'.tr),
            ],
          ),
        ),
      ),
    );
  }
}