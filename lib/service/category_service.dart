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

  @override
  String toString() => "Category<$id:$name:$image>";

  Map<String, Object?> toDocument() {
    return {
      'name': name,
      'image': image,
    };
  }

  Category copyWith({
    String? id,
    String? name,
    String? image,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.id == id &&
        other.name == name &&
        other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;
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

  // get a category by id
  Future<Category> getCategoryById(String id) async {
    final doc = await _categoryCollectionRef.doc(id).get();
    return Category.fromSnapshot(doc);
  }

  // update a category
}
