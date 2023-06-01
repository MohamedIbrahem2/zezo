import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final CollectionReference _softDeinksCollectionRef =
      FirebaseFirestore.instance.collection('SoftDrinks');

  Future<List<QueryDocumentSnapshot>> getSoftDeinks() async {
    var value = await _softDeinksCollectionRef.get();
    return value.docs;
  }
}
