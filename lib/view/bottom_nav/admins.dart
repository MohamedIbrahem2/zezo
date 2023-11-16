import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:stockat/main.dart';
import 'package:stockat/service/admin_service.dart';

class AdminsPage extends StatefulWidget {
  const AdminsPage({super.key});

  @override
  State<AdminsPage> createState() => _AdminsPageState();
}

class _AdminsPageState extends State<AdminsPage> {
  // admins services
  final adminsService = AdminService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          // add admin button
          FloatingActionButton(
        onPressed: () {
          // navigate to add admin screen
          // Navigator.pushNamed(context, '/addAdmin');
          // Get.dialog(AddAdminDialouge());
          Get.to(AddAdminDialouge());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Admins'),
      ),
      body: Center(
        child: Column(
          children: [
            // stream builder get admins
            StreamBuilder<List<UserProfile>>(
                stream: adminsService.getAdminsProfiles(),
                builder: (context, snap) => snap.hasData
                    ?
                    // list view builder
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: snap.data!.length,
                        itemBuilder: (context, index) => AdminProfileCard(
                              userProfile: snap.data![index],
                            ))
                    : const CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

// user profile card

class AdminProfileCard extends StatelessWidget {
  const AdminProfileCard({super.key, required this.userProfile});
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(userProfile.photo!),
        ),
        title: Text(userProfile.name),
        subtitle: Text(userProfile.email ?? 'no email'),
        // trailing: IconButton(
        //     onPressed: () async {
        //       try {
        //         await AdminService().deleteAdmin(userProfile.id!);
        //       } catch (e) {
        //         Get.snackbar('Error', e.toString(),
        //             duration: const Duration(seconds: 5),
        //             snackPosition: SnackPosition.BOTTOM,
        //             backgroundColor: Colors.red);
        //       }
        //     },
        //     icon: const Icon(Icons.delete)),
      ),
    );
  }
}

// add admin form dialog

class AddAdminDialouge extends StatelessWidget {
  AddAdminDialouge({super.key});
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  final adminService = AdminService();
  String phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Admin'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    scrollPadding: EdgeInsets.only(
                        bottom:
                            MediaQuery.of(context).viewInsets.bottom + 20 * 4),
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    scrollPadding: EdgeInsets.only(
                        bottom:
                            MediaQuery.of(context).viewInsets.bottom + 20 * 4),
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter email';
                      }
                      // regx
                      const pattern =
                          r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
                      final regExp = RegExp(pattern);
                      if (!regExp.hasMatch(value)) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    scrollPadding: EdgeInsets.only(
                        bottom:
                            MediaQuery.of(context).viewInsets.bottom + 20 * 4),
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IntlPhoneField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    initialCountryCode: 'SA',
                    onChanged: (value) {
                      phone = value.completeNumber;
                      // controller.phone = value.completeNumber;
                    },
                    validator: (value) {
                      if (value!.number.isEmpty) {
                        return 'Please enter phone';
                      }
                      // regx
                      const pattern =
                          r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
                      final regExp = RegExp(pattern);
                      if (!regExp.hasMatch(value.number)) {
                        return 'Please enter valid phone';
                      }
                      return null;
                    },
                  )
                  // TextFormField(
                  //   scrollPadding: EdgeInsets.only(
                  //       bottom:
                  //           MediaQuery.of(context).viewInsets.bottom + 20 * 4),
                  //   controller: _phoneController,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Phone',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     ),
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Please enter phone';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  ,
                  const SizedBox(
                    height: 20,
                  ),
                  // TextFormField(
                  //   scrollPadding: EdgeInsets.only(
                  //       bottom:
                  //           MediaQuery.of(context).viewInsets.bottom + 20 * 4),
                  //   controller: _addressController,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Address',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     ),
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Please enter address';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: Get.width * .9,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await adminService.addAdmin(
                                _nameController.text,
                                _emailController.text,
                                _passwordController.text,
                                phone,
                                _addressController.text);
                            Get.back();
                          }
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
