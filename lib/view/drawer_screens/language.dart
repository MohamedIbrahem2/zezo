import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  var value = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'language'.tr,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * .05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'select_your_favourite_language'.tr,
                style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent),
              ),
              const SizedBox(
                width: 15,
              ),
              Image.asset(
                'images/smiling.png',
                width: 25,
                height: 25,
              )
            ],
          ),
          SizedBox(
            height: Get.height * .1,
          ),
          RadioListTile(
            activeColor: Colors.greenAccent,
            title: const Text(
              'English',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            value: context.watch<LocalizationProvider>().locale ==
                    const Locale('en')
                ? true
                : false,
            groupValue: value,
            onChanged: (dynamic val) {
              context
                  .read<LocalizationProvider>()
                  .setLocale(const Locale('en'));
            },
          ),
          RadioListTile(
            activeColor: Colors.greenAccent,
            title: const Text(
              'عربي',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            value: context.watch<LocalizationProvider>().locale ==
                    const Locale('ar')
                ? true
                : false,
            groupValue: value,
            onChanged: (dynamic val) {
              context
                  .read<LocalizationProvider>()
                  .setLocale(const Locale('ar'));
            },
          ),
          SizedBox(
            height: Get.height * .08,
          ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  fixedSize: Size.fromWidth(Get.width * .8)),
              child: Text(
                'Ok'.tr,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ))
        ],
      ),
    );
  }
}
