import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockat/constants.dart';
import 'package:stockat/main.dart';
import 'package:stockat/reset_password.dart';
import 'package:stockat/service/products_service.dart';
import 'package:stockat/view/my_page_screens/edit_profile.dart';
import 'package:stockat/view/sign_in.dart';
import 'package:uuid/uuid.dart';

import '../addresses_pge.dart';
import '../my_page_screens/notifications_page.dart';
import '../my_page_screens/oreder_history.dart';

class Settings extends StatefulWidget {
  final String uniqueId;
  const Settings({super.key, required this.uniqueId});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String? name, email, pic;

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
      body:  StreamBuilder(
        builder: (context, snapShot2) {
          if (!snapShot2.hasData) {
            if (snapShot2.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else{
              dynamic document = snapShot2.data;
              name = document['name'];
            }


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
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
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
                      // Text(
                      //   UserProfile.fromMap(data, id: snapShot2.data!.id)
                      //       .isAdmin
                      //       .toString(),
                      // ),
                      // Text(isAdmin.toString()),
                      // Text(isAdmin ? 'Admin' : 'user'),
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        width: Get.width * .5,
                        child: Column(
                          children: [
                            LayoutBuilder(
                              builder: (context, constraints) {
                                if (constraints.maxWidth > 600) {
                                  return Text(
                                    data['name'],
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  );
                                } else {
                                  return Text(
                                    data['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black),
                                  );
                                }
                              },
                            ),
                            Text(
                              FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.email!:"لا يوجد بريد الكتروني",
                              style: TextStyle(fontSize: 17, color: mainColor),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * .13,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to( Form(child: Editprofile(uniqueId:widget.uniqueId,)));
                  },
                  child:
                      customListTile(icon: Icons.edit, title: 'تعديل الملف الشخصي'.tr),
                ),

                // reset password
                GestureDetector(
                  onTap: () {
                    Get.to(ResetPasswordView());
                  },
                  child: customListTile(
                      icon: Icons.lock_outline, title: 'إعادة تعيين كلمة السر'.tr),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to( AddressesPage(uniqueId: widget.uniqueId,));
                  },
                  child: customListTile(
                      icon: Icons.location_on_outlined,
                      title: 'عنوان التوصيل'.tr),
                ),

                GestureDetector(
                  onTap: () {
                    if(FirebaseAuth.instance.currentUser == null){
                      Get.snackbar("لا يمكن اتمام العمليه", "لأتمام العمليه يجب تسجيل الدخول");
                      Get.to( const SignIn());
                    }else{
                      Get.to(const OrderHistory());
                    }

                  },
                  child: customListTile(
                      icon: Icons.history, title: 'طلباتي'.tr),
                ),
                // GestureDetector(
                //   onTap: () {
                //     Get.to(const MyOfficialPapers());
                //   },
                //   child: CustomListTile(
                //       icon: Icons.card_giftcard, title: 'My official papers'),
                // ),
                GestureDetector(
                  onTap: () {
                    if(FirebaseAuth.instance.currentUser == null){
                      Get.snackbar("لا يمكن اتمام العمليه", "لأتمام العمليه يجب تسجيل الدخول");
                      Get.to( const SignIn());
                    }else{
                      Get.to(NotificationsPage(
                          userId: FirebaseAuth.instance.currentUser!.uid));
                    }

                  },
                  child: customListTile(
                      icon: Icons.notification_important_outlined,
                      title: 'الاشعارات'.tr),
                ),
                GestureDetector(
                  onTap: () {
                    if(FirebaseAuth.instance.currentUser == null){
                      Get.snackbar("لا يمكن اتمام العمليه", "لأتمام العمليه يجب تسجيل الدخول");
                      Get.to( const SignIn());
                    }else{
                      Get.defaultDialog(
                          title: 'Are you sure?'.tr,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'No'.tr,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white, elevation: 10),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(const SignIn());
                                },
                                child: Text('yes'.tr,
                                    style: const TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red, elevation: 10),
                              ),
                            ],
                          ));
                    }

                  },
                  child: customListTile(icon: Icons.logout, title: 'تسجيل الخروج'.tr),
                ),
              ],
            ),
          );
        },
        stream:FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.uid : widget.uniqueId)
            .snapshots(),
      )
    );
  }

  Widget customListTile({icon, title}) {
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
        color: Colors.pinkAccent.shade100,
      ),
    );
  }
}
