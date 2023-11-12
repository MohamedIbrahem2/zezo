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
    mapHelper.setCurrentLocation();
    super.initState();
  }

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
                      bool serviceEnabled;
                      LocationPermission permission;

                      serviceEnabled =
                          await Geolocator.isLocationServiceEnabled();
                      if (!serviceEnabled) {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                            '''Location services are disabled Please enable location services   ''',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20)),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Container(
                                              alignment: Alignment.center,
                                              width: 100,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.blue),
                                              child: const Text(
                                                'Ok',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                        return;
                      }

                      permission = await Geolocator.checkPermission();

                      if (permission == LocationPermission.denied) {
                        permission = await Geolocator.requestPermission();
                        if (permission == LocationPermission.denied) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text(
                                        'Location permissions are denied'),
                                    content: const Text(
                                        'Please enable location permissions'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  ));
                          return;
                        }
                      }

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
              ],
            ),
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

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }

  return Geolocator.getCurrentPosition();
}
