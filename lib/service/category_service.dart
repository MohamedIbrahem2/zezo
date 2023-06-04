import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String name;
  final String image;

  Category({required this.id, required this.name, required this.image});

  factory Category.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Category(
      id: snapshot.id,
      name: data['name'],
      image: data['image'],
    );
  }
}

class CategoryService {
  final CollectionReference _categoryCollectionRef =
      FirebaseFirestore.instance.collection('categories');

Stream<List<Category>> getCategories() {
  final collection = FirebaseFirestore.instance.collection('categories');
  return collection.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Category.fromSnapshot(doc)).toList();
  });
}


  // add a category
  Future<void> addCategory(String name, String image) async {
    await _categoryCollectionRef.add({
      'name': name,
      'image': image,
    });
  }
}
