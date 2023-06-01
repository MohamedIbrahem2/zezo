import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/constants.dart';
import 'package:stockat/view/my_page_screens/edit_profile.dart';
import 'package:stockat/view/sign_in.dart';

import '../my_page_screens/my_official_papers.dart';
import '../my_page_screens/oreder_history.dart';

class Screen3 extends StatelessWidget {
  var name, email, pic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (context, snapShot2) {
          if (snapShot2.hasData) {
            dynamic document = snapShot2.data;
            name = document['name'];
            email = document['email'];
            pic = document['pic'];
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 70),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://scontent.fcai20-5.fna.fbcdn.net/v/t39.30808-1/241663445_3031284463806334_9084738319430362880_n.jpg?stp=dst-jpg_p160x160&_nc_cat=110&ccb=1-7&_nc_sid=7206a8&_nc_ohc=vSFT4btO-wAAX-n-1Lw&_nc_ht=scontent.fcai20-5.fna&oh=00_AfB2bIzNIkX6o522FKDAChtL7-dkYnUh55MQ_rJy0KMY6Q&oe=643319A6'),
                        radius: 45,
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Text(
                          'Khaled Sallam',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'khaled@gmal.com',
                          style: TextStyle(fontSize: 17, color: mainColor),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * .13,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(Editprofile());
                },
                child: CustomListTile(icon: Icons.edit, title: 'Edit Profile'),
              ),
              CustomListTile(
                  icon: Icons.location_on_outlined, title: 'Shipping address'),
              GestureDetector(
                onTap: () {
                  Get.to(OrderHistory());
                },
                child:
                    CustomListTile(icon: Icons.history, title: 'Order History'),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(MyOfficialPapers());
                },
                child: CustomListTile(
                    icon: Icons.card_giftcard, title: 'My official papers'),
              ),
              CustomListTile(
                  icon: Icons.notification_important_outlined,
                  title: 'Notification'),
              GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                      title: 'Are you sure?',
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'No',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white, elevation: 10),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.to(SignIn());
                            },
                            child: Text('yes',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red, elevation: 10),
                          ),
                        ],
                      ));
                },
                child: CustomListTile(icon: Icons.logout, title: 'LogOut'),
              ),
            ],
          );
        },
        stream: null,
      ),
    );
  }

  Widget CustomListTile({icon, title}) {
    return ListTile(
      title: Text(
        '$title',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_outlined,
        color: Colors.black,
      ),
      leading: Container(
        child: Icon(
          icon,
          size: 15,
          color: Colors.black,
        ),
        height: 25,
        width: 25,
        color: Colors.blue.shade100,
      ),
    );
  }
}
