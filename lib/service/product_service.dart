import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String categoryId;
  final String subcategoryId;
  final double discount;
  final String image;
  final int salesCount;
  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.categoryId,
      required this.image,
      required this.salesCount,
      required this.subcategoryId,
      required this.discount});

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Product(
      id: snapshot.id,
      name: data['name'],
      price: (data['price'] as num).toDouble(),
      categoryId: data['categoryId'],
      subcategoryId: data['subcategoryId'],
      discount: data['discount'],
      image: data['image'],
      salesCount: data['salesCount'],
    );
  }
}

class ProductsService {
  Future<void> addProduct(
      String productName,
      double productPrice,
      double discount,
      String image,
      String categoryId,
      String subcategoryId) async {
    final collection = FirebaseFirestore.instance.collection('products');
    await collection.add({
      'name': productName,
      'price': productPrice,
      'categoryId': categoryId,
      'subcategoryId': subcategoryId,
      'discount': discount,
      'image': image,
      'salesCount': 0,
    });
  }

  Stream<List<Product>> getProducts() {
    final collection = FirebaseFirestore.instance.collection('products');
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Product>> getProductsByCategory(String categoryId) {
    final collection = FirebaseFirestore.instance.collection('products');
    return collection
        .where('categoryId', isEqualTo: categoryId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Product>> getProductsBySubcategory(String subcategoryId) {
    final collection = FirebaseFirestore.instance.collection('products');
    return collection
        .where('subcategoryId', isEqualTo: subcategoryId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  // get the best selling products

  Stream<List<Product>> getBestSellingProducts() {
    final collection = FirebaseFirestore.instance.collection('products');
    return collection
        .orderBy('salesCount', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  // search for a product
  Stream<List<Product>> searchForProduct(String? productName) {
    final collection = FirebaseFirestore.instance.collection('products');
    return collection
        .where('name', isEqualTo: productName)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }
}
