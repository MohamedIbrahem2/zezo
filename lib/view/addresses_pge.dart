import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:stockat/constants.dart';
import 'package:stockat/view/select_location_screen.dart';
import 'package:stockat/view/sign_in.dart';

import '../service/address_service.dart';

class AddressesPage extends StatefulWidget {
  final String uniqueId;
  const AddressesPage({super.key, required this.uniqueId});

  @override
  State<AddressesPage> createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  late final AddressService _addressService = AddressService(
    FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.uid : widget.uniqueId,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: const Text('عنوان التوصيل',style: TextStyle(color: Colors.white),),
          backgroundColor: mainColor),
      body: Column(
        children: [
          StreamBuilder<List<Address>>(
              stream: _addressService.stream,
              builder: (context, snapHost) {
                if (snapHost.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapHost.data!.length,
                    itemBuilder: (context, index) {
                      final document = snapHost.data![index];
                      return ListTile(
                        title: Text(document.city),
                        subtitle: Text(document.street),
                        trailing: IconButton(
                          onPressed: () {
                            _addressService.deleteAddress(document.id!);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      );
                    },
                  );
                }
                if (snapHost.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
          SizedBox(height: 35,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(250),
                backgroundColor: mainColor),
              onPressed: () {
                if(FirebaseAuth.instance.currentUser == null){
                  Get.snackbar("لا يمكن اتمام العمليه", "لأتمام العمليه يجب تسجيل الدخول");
                  Get.to( const SignIn());
                }else{
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectAdressScreen()));
                }

                // _addressService.addAddress(Address(
                //     state: 'state',
                //     postalCode: 'postalCode',
                //     latitude: 23.0,
                //     longitude: 23.0,
                //     city: 'city',
                //     street: 'street',
                //     description: 'country'));
              },
              child: const Text('اضافه عنوان',style: TextStyle(
                color: Colors.white
              ),))
        ],
      ),
    );
  }
}
