import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHelper extends ChangeNotifier {
  late GoogleMapController controller;
  final CameraPosition initialPosition = const CameraPosition(
    target: LatLng(30.22555111681319, 31.465171657209957),
    zoom: 15,
  );
  void init(GoogleMapController ctr) {
    controller = ctr;
    addMarker(initialPosition.target);
  }

  Future<Placemark> getAdressFromCurrent() async {
    print('markers.first.position.latitude');
    final placemarks = await placemarkFromCoordinates(
      markers.first.position.latitude,
      markers.first.position.longitude,
      localeIdentifier: 'ar',
    );
    final placemark = placemarks.first;
    return placemark;
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

  void getLocationFromAdreees() {
    locationFromAddress(searchController.text).then((value) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              value.first.latitude,
              value.first.longitude,
            ),
            zoom: 15,
          ),
        ),
      );
    });
  }

  Future<List<Location>> searchFromAdreees(String query) async =>
      locationFromAddress(query);

  void addMarker(LatLng point) {
    markers
      ..clear()
      ..add(
        Marker(
          markerId: const MarkerId('1'),
          position: point,
          infoWindow: const InfoWindow(
            title: 'Location',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
        ),
      );
    notifyListeners();
  }

  final Set<Marker> markers = {};
  final searchController = TextEditingController();
}

// class Search extends SearchDelegate<String> {
//   Search(this.mapHelper);
//   final MapHelper mapHelper;
//   List quotes = <String>[];
//   String author = '';
//   String result = '';
//   List<Location> locations = [];
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//           close(context, result);
//         },
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, result);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     mapHelper.searchFromAdreees(query).then(
//       (value) {
//         locations = value;
//       },
//     );
//     return ListView.builder(
//       itemCount: 3,
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//           title: Text(
//             locations.length.toString(),
//           ),
//           onTap: () {
//             result = 'suggestions.elementAt(index)';
//             close(context, result);
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     mapHelper.searchFromAdreees(query).then(
//       (value) {
//         locations = value;
//       },
//     );
//     return ListView.builder(
//       itemCount: locations.length,
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//           title: Text(
//             locations,
//           ),
//           onTap: () {
//             query = 'qmwd';
//           },
//         );
//       },
//     );
//   }
// }
