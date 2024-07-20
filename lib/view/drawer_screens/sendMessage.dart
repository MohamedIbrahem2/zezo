import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http ;
import 'package:flutter/material.dart';
import 'package:stockat/constants.dart';
import 'package:stockat/fcm_provider.dart';
import 'package:stockat/service/product_service.dart';
class SendMessage extends StatefulWidget {
  const SendMessage({super.key});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  final _fromKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  bool _isLoading = false;
  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }
  void _sendMessage(String message,String title) async {
    try {
      Get.snackbar('جاري التحميل', 'من فضلك انتظر',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: mainColor);
      List<String> tokens = await ProductsService().getAllTokens();
      await FcmProvider().sendMessage(tokens, message, title, _setLoading);
    } catch (e) {
      print('An error occurred: $e');
      _setLoading(false); // Ensure loading is stopped in case of an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _fromKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('أٍرسال رساله',textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white),),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                      // name of category
                      child: TextFormField(
                        controller: titleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك ادخل عنوان الرساله';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'عنوان الرساله',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                  // add button
                  ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  // name of category
                  child: TextFormField(
                    controller: bodyController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك أدخل محتوي الرساله';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'محتوي الرساله',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  // add button
                ),
              ),
              ElevatedButton(onPressed: () {
                _sendMessage(bodyController.text, titleController.text);
              },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor
                  ),
                  child: const Text("أرسل الرساله",textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white),))
            ],
          ),
          ),
        ),
    );
  }
}
sendMessage(title , message)async {
  var headersList = {
    'Accept': '*/*',
    'Content-Type': 'application/json',
    'Authorization': 'key=AAAAqPzP7mI:APA91bFp0h8aIwpfIOEqYcA49RBidh8uDg_ns7hGy9ketdNmQZsysXSeak7mbjCLhuVF9Pv0YBfLl-tXwHOq9nuYoRPc8CIuzu38sEYt9XGFsYYdMBT2iKB74LbBgAxfs8SOYBODNNKs'
  };
  var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  var body = {
    "to": '',
    "notification": {
      "title": title,
      "body": message
    }
  };

  var req = http.Request('POST', url);
  req.headers.addAll(headersList);
  req.body = json.encode(body);

  Get.snackbar('جاري التحميل', 'من فضلك انتظر',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: mainColor);
  var res = await req.send();
  final resBody = await res.stream.bytesToString();

  if (res.statusCode >= 200 && res.statusCode < 300) {
    Get.snackbar('تم الأرسال', 'بنجاح',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green);
    print(resBody);
  }
  else {
    Get.snackbar('فشل', 'حدث خطأ ما',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red);
    print(res.reasonPhrase);
  }
}


