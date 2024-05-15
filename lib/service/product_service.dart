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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'categoryId': categoryId,
      'subcategoryId': subcategoryId,
      'discount': discount,
      'image': image,
      'salesCount': salesCount,
    };
  }

  Product copyWith({
    String? name,
    double? price,
    String? categoryId,
    String? subcategoryId,
    double? discount,
    String? image,
    int? salesCount,
  }) {
    return Product(
      id: id,
      name: name ?? this.name,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      subcategoryId: subcategoryId ?? this.subcategoryId,
      discount: discount ?? this.discount,
      image: image ?? this.image,
      salesCount: salesCount ?? this.salesCount,
    );
  }
}

class ProductsService {
  Future<void> addProduct(
      {required String productName,
      required double productPrice,
      required double discount,
      required String image,
      required String categoryId,
      required String subcategoryId}) async {
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

  Future<void> addProductToBestSelling(Product product) async{
    final collection = FirebaseFirestore.instance.collection('bestselling');
    await collection.add({
      'name': product.name,
      'price': product.price,
      'categoryId': product.categoryId,
      'subcategoryId': product.subcategoryId,
      'discount': product.discount,
      'image': product.image,
      'salesCount': 0,
    });


  }
  Future<void> removeProductFromBestSelling(Product product) async{
    final collection = FirebaseFirestore.instance.collection('bestselling');
    await collection.doc(product.id).delete();
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
  //delete Subcategory by id
  Future<void> deleteSubcategory(String subcategoryId) async{
    final CollectionReference dataCollection = 
        FirebaseFirestore.instance.collection('subcategories');
    await dataCollection.doc(subcategoryId).delete();
  }
  //delete Category by id
  Future<void> deleteCategory(String categoryId) async{
    final CollectionReference dataCollection =
    FirebaseFirestore.instance.collection('categories');
    await dataCollection.doc(categoryId).delete();
  }
  //delete Product by id
  Future<void> deleteProduct(String productId) async{
    final CollectionReference dataCollection =
    FirebaseFirestore.instance.collection('products');
    await dataCollection.doc(productId).delete();
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
    final collection = FirebaseFirestore.instance.collection('bestselling');
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
        .where('name' , isGreaterThanOrEqualTo: productName)
        .where('name' , isLessThanOrEqualTo: productName!+ '\uf7ff')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

// update product
  Future<void> updateProduct(
    Product product,
  ) async {
    final collection = FirebaseFirestore.instance
        .collection('products')
        .doc(product.id)
        .update(product.toMap());

    await collection;


  }
  Future<Product> getProductById(String productId) async {
    final collection = FirebaseFirestore.instance.collection('products');
    final doc = await collection.doc(productId).get();
    return Product.fromSnapshot(doc);
  }
}
