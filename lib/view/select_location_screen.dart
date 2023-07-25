import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stockat/service/address_service.dart';

import '../service/map_helper.dart';

class SelectAdressScreen extends StatefulWidget {
  const SelectAdressScreen({super.key});

  @override
  State<SelectAdressScreen> createState() => _SelectAdressScreenState();
}

class _SelectAdressScreenState extends State<SelectAdressScreen> {
  final mapHelper = MapHelper();
  @override
  void initState() {
    mapHelper.addListener(() {
      setState(() {});
    });
    super.initState();
  }

// String city = '';
//   String street = '';
//   String state = '';
//   String country = '';
//   String postalCode = '';
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();

  String city = '';
  String street = '';
  String state = '';
  String country = '';
  String postalCode = '';
  @override
  void dispose() {
    mapHelper.dispose();
    super.dispose();
  }

  void setDataFormPlacMaek(Placemark p) {
    if (p.locality != null) city = p.locality!;
    if (p.street != null) street = p.street!;
    if (p.administrativeArea != null) state = p.administrativeArea!;
    if (p.country != null) country = p.country!;
    if (p.postalCode != null) postalCode = p.postalCode!;
    cityController.text = city;
    streetController.text = street;
    stateController.text = state;
    countryController.text = country;
    postalCodeController.text = postalCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     left: 20,
          //     right: 20,
          //   ),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: TextFormField(
          //           controller: mapHelper.searchController,
          //           decoration: InputDecoration(
          //             // prefixIcon: widget(child: const Icon(Icons.search)),
          //             labelText: 'Search Location',
          //             suffixIcon: IconButton(
          //               icon: const Icon(Icons.search),
          //               onPressed: mapHelper.getLocationFromAdreees,
          //             ),
          //           ),
          //         ),
          //       ),
          //       // IconButton(
          //       //   icon: const Icon(Icons.location_searching),
          //       //   onPressed: () async {
          //       //     final position = await determinePosition();
          //       //     mapHelper.addMarker(
          //       //       LatLng(position.altitude, position.longitude),
          //       //     );
          //       //     await mapHelper.controller.animateCamera(
          //       //       CameraUpdate.newLatLng(
          //       //         LatLng(position.altitude, position.longitude),
          //       //       ),
          //       //     );
          //       //   },
          //       // )
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: const Text('Current location'),
                    onPressed: () async {
                      final position = await determinePosition();
                      mapHelper.addMarker(
                        LatLng(position.latitude, position.longitude),
                      );
                      await mapHelper.controller.animateCamera(
                        CameraUpdate.newLatLng(
                          LatLng(position.latitude, position.longitude),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    child: const Text('Work Area'),
                    onPressed: () async {
                      mapHelper.addMarker(
                        const LatLng(30.22555111681319, 31.465171657209957),
                      );
                      await mapHelper.controller.animateCamera(
                        CameraUpdate.newLatLng(
                          const LatLng(30.22555111681319, 31.465171657209957),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          const Text(
            'Please Note The Area Of Our Work Is Obour Area',
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GoogleMap(
              onCameraMove: (position) {
                mapHelper.addMarker(position.target);
              },
              myLocationEnabled: true,
              onTap: (point) async {
                mapHelper.addMarker(point);
              },
              markers: mapHelper.markers,
              onMapCreated: mapHelper.init,
              initialCameraPosition: mapHelper.initialPosition,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: const Text('add address'),
            onPressed: () async {
              // 30.285390, 31.476819
              // const l1 = 30.285390;
              // const l2 = 30.172212;
              // const t1 = 31.505681;
              // const t2 = 31.437411;
              // if ((mapHelper.markers.last.position.latitude < l2 ||
              //         mapHelper.markers.last.position.latitude > l1) ||
              //     (mapHelper.markers.last.position.longitude > t1 ||
              //         mapHelper.markers.last.position.longitude < t2)) {
              //   await Fluttertoast.showToast(
              //     msg: 'this area out of our work',
              //   );
              //   return;
              // }

              final placeMark = await mapHelper.getAdressFromCurrent();
              if (!mounted) return;
              final name = placeMark.name ?? '';
              final subLocality = placeMark.subLocality ?? '';
              final locality = placeMark.locality ?? '';

              final administrativeArea = placeMark.administrativeArea ?? '';
              final postalCode = placeMark.postalCode ?? '';
              final country = placeMark.country ?? '';
              final address =
                  '$name, $subLocality, $locality, $administrativeArea $postalCode, $country';
              setDataFormPlacMaek(placeMark);
              await showDialog<void>(
                context: context,
                builder: (context) {
                  return AddressDesc(
                    cityController: cityController,
                    stateController: stateController,
                    streetController: streetController,
                    postalCodeController: postalCodeController,
                    address: address,
                    mapHelper: mapHelper,
                  );
                },
              );
              // context.read<AuthenticationBloc>().add(
              //       UpdateAddresses(
              //         Address(
              //           id: '',
              //           address: address,
              //           description: ,
              //           coordinates: [
              //             mapHelper.markers.last.position.latitude,
              //             mapHelper.markers.last.position.longitude,

              //           ],
              //         ),
              //       ),
              //     );

              // Navigator.pop<Address>(
              //   context,
              //   Address(
              //       description: '',
              //       city: cityController.text,
              //       state: stateController.text,
              //       street: streetController.text,
              //       postalCode: postalCodeController.text,
              //       latitude: mapHelper.markers.last.position.latitude,
              //       longitude: mapHelper.markers.last.position.longitude),
              // );
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class AddressDesc extends StatefulWidget {
  const AddressDesc({
    super.key,
    required this.address,
    required this.mapHelper,
    required this.cityController,
    required this.stateController,
    required this.streetController,
    required this.postalCodeController,
  });
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController streetController;
  final TextEditingController postalCodeController;

  final String address;
  final MapHelper mapHelper;

  @override
  State<AddressDesc> createState() => _AddressDescState();
}

class _AddressDescState extends State<AddressDesc> {
  final textController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _fromKey,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: SizedBox(
            // height: 550,
            width: 320,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Submit Your Address',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // const SizedBox(height: 20),
                  TextFormField(
                    controller: widget.cityController,
                    validator: (value) =>
                        value!.isEmpty ? 'Please Write your city' : null,
                    decoration: InputDecoration(
                      hintText: 'Write You City',
                      contentPadding: const EdgeInsets.all(8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: widget.stateController,
                    validator: (value) =>
                        value!.isEmpty ? 'Please Write your state' : null,
                    decoration: InputDecoration(
                      hintText: 'Write You State',
                      contentPadding: const EdgeInsets.all(8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: widget.streetController,
                    validator: (value) =>
                        value!.isEmpty ? 'Please Write your street' : null,
                    decoration: InputDecoration(
                      hintText: 'Write You Street',
                      contentPadding: const EdgeInsets.all(8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: widget.postalCodeController,
                    validator: (value) =>
                        value!.isEmpty ? 'Please Write your postal code' : null,
                    decoration: InputDecoration(
                      hintText: 'Write You Postal Code',
                      contentPadding: const EdgeInsets.all(8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: textController,
                    minLines: 4,
                    maxLines: 5,
                    validator: (value) => value!.isEmpty
                        ? 'Please Write your address description'
                        : null,
                    decoration: InputDecoration(
                      hintText: 'Write You Addres Description',
                      contentPadding: const EdgeInsets.all(8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    child: const Text('Confirm'),
                    onPressed: () {
                      if (!_fromKey.currentState!.validate()) return;

                      final addess = Address(
                          description: textController.text,
                          city: widget.cityController.text,
                          state: widget.stateController.text,
                          street: widget.streetController.text,
                          postalCode: widget.postalCodeController.text,
                          latitude:
                              widget.mapHelper.markers.last.position.latitude,
                          longitude:
                              widget.mapHelper.markers.last.position.longitude);
                      AddressService(
                        FirebaseAuth.instance.currentUser!.uid,
                      ).addAddress(addess);
                      // context.read<AuthenticationBloc>().add(
                      //       UpdateAddresses(
                      //         Address(
                      //           id: '',
                      //           address: widget.address,
                      //           description: textController.text,
                      //           coordinates: [
                      //             widget.mapHelper.markers.last.position.latitude,
                      //             widget
                      //                 .mapHelper.markers.last.position.longitude,
                      //           ],
                      //         ),
                      //       ),
                      //     );

                      Navigator.pop<String>(
                        context,
                        '',
                      );
                      Navigator.pop<String>(
                        context,
                        '',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return Geolocator.getCurrentPosition();
}
