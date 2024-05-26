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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Subcategory &&
        other.id == id &&
        other.name == name &&
        other.categoryId == categoryId &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ categoryId.hashCode ^ image.hashCode;
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

  // get all subcategories
  Stream<List<Subcategory>> getSubcategories() {
    final collection = FirebaseFirestore.instance.collection('subcategories');
    return collection.snapshots().map((snapshot) {
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
        .where('name' , isGreaterThanOrEqualTo: searchValue)
        .where('name' , isLessThanOrEqualTo: searchValue!+ '\uf7ff')
        .where('categoryId', isEqualTo: categoryId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Subcategory.fromSnapshot(doc)).toList();
    });
  }

  // get subcategory by id
  Future<Subcategory> getSubcategoryById(String id) {
    final collection = FirebaseFirestore.instance.collection('subcategories');
    return collection
        .doc(id)
        .get()
        .then((doc) => Subcategory.fromSnapshot(doc));
  }
}