import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/constants.dart';
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
            backgroundColor: mainColor,
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