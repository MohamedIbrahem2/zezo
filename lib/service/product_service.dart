import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String brand;
  final String category;
  final double regularPrice;
  final String description;
  final double discountPrice;
  final double stock;
  final String title;
  final String weight;
  final List images;
  Product(
      {
        required this.category,
        required this.brand,
        required this.description,
        required this.stock,
        required this.title,
        required this.weight,
        required this.id,
        required this.regularPrice,
        required this.images,
        required this.discountPrice});

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    double parseDouble(dynamic value) {
      if (value is num) {
        return value.toDouble();
      } else if (value is String) {
        return double.tryParse(value) ?? 0.0;
      } else {
        return 0.0;
      }
    }
    return Product(
      id: snapshot.id,
      regularPrice: parseDouble(data['regularPrice']),
      discountPrice: parseDouble(data['discountPrice']),
      images: data['images'],
      brand: data['brand'],
      description: data['description'],
      stock: parseDouble(data['stock']),
      title: data['title'],
      weight: data['weight'],
      category: 'category',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'regularPrice': regularPrice,
      'discount': discountPrice,
      'images': images,
      'brand': brand,
      'description': description,
      'stock' : stock,
      'title' : title,
      'weight' : weight,
      'category': category
    };
  }

  Product copyWith({
    double? regularPrice,
    double? discountPrice,
    String? images,
    String? brand,
    String? description,
    double? stock,
    String? title,
    String? weight
  }) {
    return Product(
      id: id,
      regularPrice: regularPrice ?? this.regularPrice,
      discountPrice: discountPrice ?? this.discountPrice,
      brand: brand ?? this.brand,
      description: description ?? this.description,
      stock: stock ?? this.stock,
      title: title ?? this.title,
      weight: weight ?? this.weight,
      images: [],
      category: category,

    );
  }
}

class ProductsService {
  Future<void> addProduct(
      {required String productName,
        required bool available,
        required double productPrice,
        required double discount,
        required String image,
        required String categoryId,
        required String subcategoryId}) async {
    final collection = FirebaseFirestore.instance.collection('products');
    await collection.add({
      'avalible' : true,
      'name': productName,
      'price': productPrice,
      'categoryId': categoryId,
      'subcategoryId': subcategoryId,
      'discount': discount,
      'image': image,
      'salesCount': 0,
      'isbestselling' : false
    });
  }

  Stream<List<Product>> getProducts() {
    final collection = FirebaseFirestore.instance.collection('products');
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }
  Stream<List<Product>> getUnavailableProducts() {
    final collection = FirebaseFirestore.instance.collection('products');
    return collection.where('avalible', isEqualTo: false).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }
  Future<void> productNotAvailable(String product) async {
    final collection = FirebaseFirestore.instance.collection('products');
    return await collection.doc(product).update(
        {
      'avalible' : false,
    },
    );
  }
  Future<void> productAvailable(String product)async{
    final collection = FirebaseFirestore.instance.collection('products');
    return await collection.doc(product).update(
        {
          'avalible' : true,
        },
    );
  }


  Future<void> addProductToBestSelling(Product product) async{
    final collection = FirebaseFirestore.instance.collection('products');
    await collection.doc(product.id).update({
      "isbestselling" : true,
    });


  }
  Future<void> removeProductFromBestSelling(Product product) async{
    final collection = FirebaseFirestore.instance.collection('products');
    await collection.doc(product.id).update({
      'isbestselling' : false,
    });
  }
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<List<String>> getAllTokens() async {
    QuerySnapshot snapshot = await _db.collection('users').where('fcm', isNotEqualTo: null).get();

    List<String> tokens = snapshot.docs.map((doc) => doc['fcm'] as String).toList();

    return tokens;
  }

  Stream<List<Product>> getProductsByCategory(String categoryId) {
    final collection = FirebaseFirestore.instance.collection('products');
    return collection
        .where('category', isEqualTo: categoryId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }
  /*Future<void> removeProductFromBestSellingTest() async{
    final collection = FirebaseFirestore.instance.collection('products');
    await collection.get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.set({
          'isbestselling': false,
        },
        SetOptions(merge: true)
        );
      }
    });
  }

   */
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
  Future<void> deleteProductFromBestSelling(String productId) async{
    final CollectionReference dataCollection =
    FirebaseFirestore.instance.collection('bestselling');
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
    final collection = FirebaseFirestore.instance.collection('products');
    return collection
        .where('isbestselling', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  // search for a product
  Stream<List<Product>> searchForProduct(String? productName) {
    final collection = FirebaseFirestore.instance.collection('products');
    return collection
        .where('title' , isGreaterThanOrEqualTo: productName)
        .where('title' , isLessThanOrEqualTo: productName!+ '\uf7ff')
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