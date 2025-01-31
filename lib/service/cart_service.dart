import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:stockat/constants.dart';

class CartItem {
  final String id;
  final String productId;
  final String productName;
  final String image;
  final double price;
  final int quantity;
// to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'image': image,
    };
  }

  CartItem.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        productId = map['productId'],
        productName = map['productName'],
        price = map['price'],
        image = map['image'] ?? '',
        quantity = map['quantity'];
  CartItem(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.price,
      required this.image,
      required this.quantity});

  factory CartItem.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return CartItem(
      id: snapshot.id,
      productId: data['productId'],
      productName: data['productName'],
      price: data['price'],
      image: data['image'],
      quantity: data['quantity'],
    );
  }
}

class CartService {
  Future<void> addToCart(
      {required String productId,
      required String userId,
      required String productName,
      required String image,
      required double price,
      required int quantity}) async {
    final collection = FirebaseFirestore.instance.collection('cart');
    // check if the product is already in the cart
    final quantity = await isProductInCart(productId, userId);
    if (quantity == 0) {
      // add the product to the cart
      await collection.doc(productId).set({
        'productId': productId,
        'productName': productName,
        'price': price,
        'quantity': 1,
        'userId': userId,
        'image': image,
      });
      showSimpleNotification(Text("تم الأضافه الي العربه".tr,textDirection: TextDirection.rtl,),
          leading: Builder(builder: (
        context,
      ) {
        return IconButton(
            onPressed: () {
              //cancel
              OverlaySupportEntry.of(context)!.dismiss();
            },
            icon: const Icon(Icons.done));
      }), background: mainColor);
    } else {
      // update the quantity
      await updateCartItemQuantity(productId, quantity! + 1,quantity);
    }
  }

// is the product already in the cart?
  Future<int?> isProductInCart(String productId, String userId) async {
    final collection = FirebaseFirestore.instance.collection('cart');
    final snapshot = await collection
        .where('productId', isEqualTo: productId)
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs.isNotEmpty ? snapshot.docs[0].data()['quantity'] : 0;
  }

  Future<void> updateCartItemQuantity(
      String cartItemId, int newQuantity,int lastQuantity) async {
    final collection = FirebaseFirestore.instance.collection('cart');
    await collection.doc(cartItemId).update({'quantity': newQuantity});
    if (newQuantity == 0) {
      await removeCartItem(cartItemId);
    }
    if (newQuantity > lastQuantity) {
      showSimpleNotification(Text("تم الأضافه الي العربه".tr,textDirection: TextDirection.rtl,),
          leading: Builder(builder: (
        context,
      ) {
        return IconButton(
            onPressed: () {
              //cancel
              OverlaySupportEntry.of(context)!.dismiss();
            },
            icon: const Icon(Icons.done));
      }), background: mainColor);
      // Get.closeAllSnackbars();
      // Get.snackbar('Done', 'Added to cart successfully');
    } else {
      showSimpleNotification(Text("تم الحذف من العربه".tr,textDirection: TextDirection.rtl,),
          leading: Builder(builder: (
        context,
      ) {
        return IconButton(
            onPressed: () {
              //cancel
              OverlaySupportEntry.of(context)!.dismiss();
            },
            icon: const Icon(Icons.cancel));
      }), background:mainColor);
      // Get.closeAllSnackbars();

      // Get.snackbar('Done', 'Removed to cart successfully');
    }
  }

  Future<void> removeCartItem(String cartItemId) async {
    final collection = FirebaseFirestore.instance.collection('cart');
    await collection.doc(cartItemId).delete();
  }

  Stream<List<CartItem>> getCartItems(String userId) {
    final collection = FirebaseFirestore.instance.collection('cart');
    return collection
        .where(
          'userId',
          isEqualTo: userId,
        )
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => CartItem.fromSnapshot(doc)).toList();
    });
  }

  // get the total number of items in the cart
  Future<int> getTotalItems(String userId) async {
    final collection = FirebaseFirestore.instance.collection('cart');
    final snapshot = await collection.where('userId', isEqualTo: userId).get();
    int totalItems = 0;
    for (var doc in snapshot.docs) {
      totalItems += int.parse(doc.data()['quantity'].toString());
    }
    return totalItems;
  }
  // get items by product id

  Stream<List<CartItem>> getCartItemsByProductId(
      String userId, String productId) {
    final collection = FirebaseFirestore.instance.collection('cart');
    return collection
        .where(
          'userId',
          isEqualTo: userId,
        )
        .where('productId', isEqualTo: productId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => CartItem.fromSnapshot(doc)).toList();
    });
  }

// get the total price of the cart
  Future<double> getTotalPrice(String userId) async {
    final collection = FirebaseFirestore.instance.collection('cart');
    final snapshot = await collection.where('userId', isEqualTo: userId).get();
    double totalPrice = 0;
    for (var doc in snapshot.docs) {
      totalPrice += doc.data()['price'] * doc.data()['quantity'];
    }
    return totalPrice;
  }

  // clear the cart
  Future<void> clearCart(String userId) async {
    final collection = FirebaseFirestore.instance.collection('cart');
    final snapshot = await collection.where('userId', isEqualTo: userId).get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
