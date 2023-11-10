import 'package:cloud_firestore/cloud_firestore.dart';

class AddressService {
  final String userId;

  AddressService(this.userId);

  CollectionReference get _addressCollection => FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('addresses');

  Future<void> addAddress(Address address) async {
    await _addressCollection.add(address.toMap());
  }

  Future<List<Address>> getAddresses() async {
    QuerySnapshot snapshot = await _addressCollection.get();
    return snapshot.docs.map((doc) => _addressFromSnapshot(doc)).toList();
  }

// get addresses stream
  Stream<List<Address>> get stream {
    return _addressCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => _addressFromSnapshot(doc)).toList());
  }

  // delete address
  Future<void> deleteAddress(String addressId) async {
    await _addressCollection.doc(addressId).delete();
  }

  // update address
  Future<void> updateAddress(String addressId, Address address) async {
    await _addressCollection.doc(addressId).update(address.toMap());
  }

  Address _addressFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Address(
      street: data['street'],
      city: data['city'],
      state: data['state'],
      postalCode: data['postalCode'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      description: data['description'] ?? '',
      id: snapshot.id,
    );
  }
}

class Address {
  String? id;
  String street;
  String city;
  String description;

  String state;
  String postalCode;
  double latitude;
  double longitude;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.description,
    this.id,
  });

  // fromMap
  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'],
      city: map['city'],
      state: map['state'],
      postalCode: map['postalCode'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      description: map['description'] ?? '',
      id: map['id'],
    );
  }

  // Convert Address to a map
  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      if (id != null) 'id': id,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is Address &&
        other.id == id &&
        other.street == street &&
        other.city == city &&
        other.description == description &&
        other.state == state &&
        other.postalCode == postalCode &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }
}
