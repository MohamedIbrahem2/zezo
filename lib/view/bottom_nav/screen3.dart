import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockat/constants.dart';
import 'package:stockat/main.dart';
import 'package:stockat/view/my_page_screens/edit_profile.dart';
import 'package:stockat/view/sign_in.dart';

import '../addresses_pge.dart';
import '../my_page_screens/my_official_papers.dart';
import '../my_page_screens/oreder_history.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var name, email, pic;

  bool isLoading = false;

  UserProfile? userProfile;
  final _authService = AuthService();
  getUserProfile() async {
    try {
      isLoading = true;
      setState(() {});

      userProfile = await _authService
          .getUserProfile(FirebaseAuth.instance.currentUser!.uid);
      isLoading = false;
      setState(() {});
    } catch (e) {
      print(e);
      isLoading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    // getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (context, snapShot2) {
          if (snapShot2.hasData) {
            dynamic document = snapShot2.data;
            name = document['name'];
            // email = document['email'];
            // pic = document['pic'];
          }
          if (snapShot2.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (snapShot2.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapShot2.data!.data() as Map<String, dynamic>;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 70),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: data['photo'] != null
                          ? NetworkImage(snapShot2.data!['photo'])
                          : null,
                      radius: 45,
                      child: data['photo'] == null
                          ? const Icon(
                              Icons.person,
                              size: 45,
                            )
                          : null,
                      backgroundColor: Colors.blue,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          FirebaseAuth.instance.currentUser!.email!,
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
                  Get.to(const Form(child: Editprofile()));
                },
                child: CustomListTile(icon: Icons.edit, title: 'Edit Profile'),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const AddressesPage());
                },
                child: CustomListTile(
                    icon: Icons.location_on_outlined,
                    title: 'Shipping address'),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(OrderHistory());
                },
                child:
                    CustomListTile(icon: Icons.history, title: 'Order History'),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const MyOfficialPapers());
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
                            child: const Text(
                              'No',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white, elevation: 10),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.to(const SignIn());
                            },
                            child: const Text('yes',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red, elevation: 10),
                          ),
                        ],
                      ));
                },
                child: CustomListTile(icon: Icons.logout, title: 'LogOut'),
              ),
            ],
          );
        },
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
      ),
    );
  }

  Widget CustomListTile({icon, title}) {
    return ListTile(
      title: Text(
        '$title',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(
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
