import 'package:cloud_firestore/cloud_firestore.dart';

class Subcategory {
  final String id;
  final String name;
  final String categoryId;
  final String image;

  Subcategory(
      {required this.id,
      required this.name,
      required this.categoryId,
      required this.image});

  factory Subcategory.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Subcategory(
      id: snapshot.id,
      name: data['name'],
      categoryId: data['categoryId'],
      image: data['image'],
    );
  }
}

class SubCategoryService {
  Future<void> addSubcategory(
      String subcategoryName, String categoryId, String image) async {
    final collection = FirebaseFirestore.instance.collection('subcategories');
    await collection.add(
        {'name': subcategoryName, 'categoryId': categoryId, 'image': image});
  }

  Stream<List<Subcategory>> getSubcategoriesByCategory(String categoryId) {
    final collection = FirebaseFirestore.instance.collection('subcategories');
    return collection
        .where('categoryId', isEqualTo: categoryId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Subcategory.fromSnapshot(doc)).toList();
    });
  }

  // search subcategories
  Stream<List<Subcategory>> searchSubcategories(String searchValue) {
    final collection = FirebaseFirestore.instance.collection('subcategories');
    return collection
        .where('name', isGreaterThanOrEqualTo: searchValue)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Subcategory.fromSnapshot(doc)).toList();
    });
  }

  // serach subcategories by category
  Stream<List<Subcategory>> searchSubcategoriesByCategory(
      String? searchValue, String categoryId) {
    final collection = FirebaseFirestore.instance.collection('subcategories');
    return collection
        .where('name', isEqualTo: searchValue)
        .where('categoryId', isEqualTo: categoryId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Subcategory.fromSnapshot(doc)).toList();
    });
  }
}
