// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:stockat/service/product_service.dart';

// class Package {
//   final String id;
//   final String name;
//   final double price;

//   final List<String> productIds;
//   final String type;
//   Package({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.productIds,
//     required this.type,
//   });
//   factory Package.fromSnapshot(DocumentSnapshot snapshot) {
//     final data = snapshot.data() as Map<String, dynamic>;
//     final productIds = List<String>.from(data['productIds']);
//     return Package(
//       id: snapshot.id,
//       name: data['name'],
//       price: data['price'],
//       productIds: productIds,
//       type: data['type'],
//     );
//   }
// }

// class Offer {
//   final String id;
//   final String name;
//   final double price;
//   final String image;
//   final List<String> productIds;
//   final List<String> packagesIds;
//   final String type;

//   Offer({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.image,
//     required this.productIds,
//     required this.type,
//     required this.packagesIds,
//   });

//   factory Offer.fromSnapshot(DocumentSnapshot snapshot) {
//     final data = snapshot.data() as Map<String, dynamic>;
//     final productIds = List<String>.from(data['productIds']);
//     return Offer(
//       id: snapshot.id,
//       name: data['name'],
//       price: data['price'],
//       image: data['image'],
//       productIds: productIds,
//       type: data['type'],
//       packagesIds: data['packagesIds'],
//     );
//   }
// }

// class OfferService {
//   Future<void> createPackageOffer(
//     String offerName,
//     List<String> packagesIds,
//     double packagePrice,
//     String photoUrl,
//   ) async {
//     final collection = FirebaseFirestore.instance.collection('offers');
//     final offerData = {
//       'name': offerName,
//       'type': 'package',
//       'packagesIds': packagesIds,
//       'packagePrice': packagePrice,
//       'photoUrl': photoUrl,
//     };
//     await collection.add(offerData);
//   }

//   Future<void> createDiscountOffer(
//     String offerName,
//     List<String> productIds,
//     double discountPercentage,
//     String photoUrl,
//   ) async {
//     final collection = FirebaseFirestore.instance.collection('offers');
//     final offerData = {
//       'name': offerName,
//       'type': 'discount',
//       'productIds': productIds,
//       'discountPercentage': discountPercentage,
//       'photoUrl': photoUrl,
//     };
//     await collection.add(offerData);
//   }

//   Future<void> deleteOffer(String offerId) async {
//     final collection = FirebaseFirestore.instance.collection('offers');
//     await collection.doc(offerId).delete();
//   }

//   Stream<List<Offer>> getAllOffers() {
//     final collection = FirebaseFirestore.instance.collection('offers');
//     return collection.snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) => Offer.fromSnapshot(doc)).toList();
//     });
//   }

//   Future<List<Product>> getOfferProducts(String offerId) async {
//     final collection = FirebaseFirestore.instance.collection('offers');
//     final offerDoc = await collection.doc(offerId).get();

//     if (!offerDoc.exists) {
//       throw Exception('Offer not found');
//     }

//     final offerData = offerDoc.data()!;
//     final productIds = offerData['productIds'] as List<dynamic>;

//     final productsCollection =
//         FirebaseFirestore.instance.collection('products');
//     final productsSnapshot = await productsCollection
//         .where(FieldPath.documentId, whereIn: productIds)
//         .get();

//     final products =
//         productsSnapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
//     return products;
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stockat/service/product_service.dart';

class Package {
  final String name;
  final double price;
  final List<String> productIds;

  List<Product> products = [];

  void setProducts(List<Product> products) {
    products = [...products];
  }

  Package({
    required this.name,
    required this.price,
    required this.productIds,
  });

  factory Package.fromSnapshot(Map<String, dynamic> data) {
    final productIds = List<String>.from(data['productIds']);
    return Package(
      name: data['name'],
      price: data['price'],
      productIds: productIds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'productIds': productIds,
    };
  }
}

class Offer {
  final String id;
  final String name;
  final double discount;

  final String image;
  final List<String> productIds;
  final List<Package> packages;
  final String type;

  Offer({
    required this.id,
    required this.name,
    required this.image,
    required this.productIds,
    required this.packages,
    required this.type,
    required this.discount,
  });

  factory Offer.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    List<String> productIds = [];
    if (data['productIds'] != null) {
      productIds = List<String>.from(data['productIds']);
    }
    List packagesData = (data['packages'] ?? []) as List<dynamic>;
    final packages = packagesData
        .map((packageData) => Package.fromSnapshot(packageData))
        .toList();

    return Offer(
      id: snapshot.id,
      name: data['name'],
      discount: data['discount'] ?? 0,
      image: data['image'],
      productIds: productIds,
      packages: packages,
      type: data['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'discount': discount,
      'image': image,
      'productIds': productIds,
      'packages': packages.map((package) => package.toJson()).toList(),
      'type': type,
    };
  }
}

class OfferService {
  Future<void> createPackageOffer(
    String offerName,
    List<Package> packages,
    String photoUrl,
  ) async {
    final collection = FirebaseFirestore.instance.collection('offers');
    final offerData = {
      'name': offerName,
      'type': 'package',
      'image': photoUrl,
      'packages': packages.map((package) => package.toJson()).toList(),
    };
    await collection.add(offerData);
  }

  Future<void> createDiscountOffer(
    String offerName,
    List<String> productIds,
    double discountPercentage,
    String photoUrl,
  ) async {
    final collection = FirebaseFirestore.instance.collection('offers');
    final offerData = {
      'name': offerName,
      'type': 'discount',
      'discount': discountPercentage,
      'image': photoUrl,
      'productIds': productIds,
    };
    await collection.add(offerData);
  }

  Future<void> deleteOffer(String offerId) async {
    final collection = FirebaseFirestore.instance.collection('offers');
    await collection.doc(offerId).delete();
  }

  Stream<List<Offer>> getAllOffers() {
    final collection = FirebaseFirestore.instance.collection('offers');
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Offer.fromSnapshot(doc)).toList();
    });
  }

  Future<List<Product>> getOfferProducts(String offerId) async {
    print('*' * 100);
    final collection = FirebaseFirestore.instance.collection('offers');
    final offerDoc = await collection.doc(offerId).get();
    if (!offerDoc.exists) {
      throw Exception('Offer not found');
    }

    final offerData = offerDoc.data()!;
    print(offerData);
    final productIds = offerData['productIds'] as List<dynamic>;

    final productsCollection =
        FirebaseFirestore.instance.collection('products');

    // Get products from the offer
    final productsSnapshot = await productsCollection
        .where(FieldPath.documentId, whereIn: productIds)
        .get();

    final products =
        productsSnapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    print('*' * 100);

    print(products);

    return products;
  }

  Future<List<Product>> getPackageProducts(Package package) async {
    final productsCollection =
        FirebaseFirestore.instance.collection('products');
    final productsSnapshot = await productsCollection
        .where(FieldPath.documentId, whereIn: package.productIds)
        .get();

    final products =
        productsSnapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    return products;
  }

  Future<List<Product>> getDiscountProducts(Offer offer) async {
    final productsCollection =
        FirebaseFirestore.instance.collection('products');
    final productsSnapshot = await productsCollection
        .where(FieldPath.documentId, whereIn: offer.productIds)
        .get();

    final products =
        productsSnapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    return products;
  }

  Future<List<Package>> getPackagesAndProducts(offerId) async {
    final collection = FirebaseFirestore.instance.collection('offers');
    final offerDoc = await collection.doc(offerId).get();
    final offerData = offerDoc.data()!;
    final packagesData = offerData['packages'] as List<dynamic>;
    final productsCollection =
        FirebaseFirestore.instance.collection('products');
    final productsSnapshot = productsCollection
        .where(FieldPath.documentId, whereIn: offerData['productIds'])
        .get();
    final packages = packagesData
        .map((packageData) => Package.fromSnapshot(packageData))
        .toList();
    // final products = productsSnapshot.then((value) =>
    //     value.docs.map((doc) => Product.fromSnapshot(doc)).toList());
    final prodcutsDtat = await productsSnapshot;
    final products =
        prodcutsDtat.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    return packages.map((e) => e..products = products).toList();
  }
  // return collection.doc(offerId).get().then((value) {
  //   final offerData = value.data()!;
  //   final packagesData = offerData['packages'] as List<dynamic>;
  //   final productsCollection =
  //       FirebaseFirestore.instance.collection('products');
  //   final productsSnapshot = productsCollection
  //       .where(FieldPath.documentId, whereIn: offerData['productIds'])
  //       .get();
  //   final packages = packagesData
  //       .map((packageData) => Package.fromSnapshot(packageData))
  //       .toList();
  //   final products = productsSnapshot.then((value) =>
  //       value.docs.map((doc) => Product.fromSnapshot(doc)).toList());
  //   return packages.map((e) => e..products = products).toList();
  // });
}
