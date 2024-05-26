import 'dart:convert';
import 'package:http/http.dart' as http ;
import 'package:flutter/material.dart';
class SendMessage extends StatefulWidget {
  const SendMessage({super.key});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  final _fromKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _fromKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Send Message'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                    // name of category
                    child: TextFormField(
                      controller: titleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Message Title';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Message Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                // add button
                ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                // name of category
                child: TextFormField(
                  controller: bodyController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Message Body';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Message Body',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                // add button
              ),
              ElevatedButton(onPressed: () async{
                await sendMessage(titleController.text, bodyController.text);
              }, child: const Text("Send Message"))
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
    'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    'Content-Type': 'application/json',
    'Authorization': 'key=AAAAqPzP7mI:APA91bFp0h8aIwpfIOEqYcA49RBidh8uDg_ns7hGy9ketdNmQZsysXSeak7mbjCLhuVF9Pv0YBfLl-tXwHOq9nuYoRPc8CIuzu38sEYt9XGFsYYdMBT2iKB74LbBgAxfs8SOYBODNNKs'
  };
  var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  var body = {
    "to": "eFpBfSalTR6sEWqzo44QF7:APA91bGiYznG26vD1Z4rkrrb_QrPAs62EgsgRpVk0G8qf1GYtPtlbQ2U8ypaOw17L3sqIh3QkyFV7YAqxl6tWQSzD1CG_6Joba2ymRyjwsLwj7t0zfJ2frjf97V1TjlMUIrHPukD8zTk",
    "notification": {
      "title": title,
      "body": message
    }
  };

  var req = http.Request('POST', url);
  req.headers.addAll(headersList);
  req.body = json.encode(body);


  var res = await req.send();
  final resBody = await res.stream.bytesToString();

  if (res.statusCode >= 200 && res.statusCode < 300) {
    print(resBody);
  }
  else {
    print(res.reasonPhrase);
  }
}
