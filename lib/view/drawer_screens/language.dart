import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language extends StatefulWidget {
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
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Language ',
          style: TextStyle(color: Colors.black),
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
                'Select your favourite language',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent),
              ),
              SizedBox(
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
            title: Text(
              'English',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            value: true,
            groupValue: value,
            onChanged: (dynamic val) {
              setState(() {
                value = val;
              });
            },
          ),
          RadioListTile(
            activeColor: Colors.greenAccent,
            title: Text(
              'Arabic',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            value: false,
            groupValue: value,
            onChanged: (dynamic val) {
              setState(() {
                value = val;
              });
            },
          ),
          SizedBox(
            height: Get.height * .08,
          ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent,
                  fixedSize: Size.fromWidth(Get.width * .8)),
              child: Text(
                'Ok',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ))
        ],
      ),
    );
  }
}
