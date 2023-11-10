import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File imageFile, String fileName) async {
    try {
      // Create a reference to the Firebase Storage location
      Reference storageRef = _storage.ref().child(fileName);

      // Upload the file to the specified location
      UploadTask uploadTask = storageRef.putFile(imageFile);

      // Await for the upload to complete and get the download URL
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Return the download URL
      return downloadUrl;
    } catch (e) {
      return '';
    }
  }
}
