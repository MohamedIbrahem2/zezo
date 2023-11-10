import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stockat/main.dart';

class AdminService {
// create new admin as a user an role is admin

  // create authntication user
  Future<void> addAdmin(String name, String email, String password,
      String phone, String? photo) async {
    try {
      final app = await Firebase.initializeApp(
          name: 'Secondary',
          options: Firebase.app().options); // if you are using firebase 9
      final auth = FirebaseAuth.instanceFor(app: app);
      final data = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await auth.signOut();

      final collection = FirebaseFirestore.instance.collection('users');
      await collection.doc(data.user!.uid).set({
        'name': name,
        'email': email,
        'password': password,
        'role': 'admin',
        'phone': phone,
        'isAdmin': true,
        if (photo != null) 'photo': photo,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

// get admins profiles
  Stream<List<UserProfile>> getAdminsProfiles() {
    var userData = FirebaseFirestore.instance
        .collection('users')
        .where('isAdmin', isEqualTo: true)
        .snapshots();
    return userData.map((snapshot) {
      return snapshot.docs.map((doc) => UserProfile.fromSnapshot(doc)).toList();
    });

    //  get user email
    // var userData = FirebaseFirestore.instance
    //     .collection('users')
    //     .where('isAdmin', isEqualTo: true);
    // return userData.docs.map((doc) => UserProfile.fromSnapshot(doc)).toList();
  }

  // delete admin
  Future deleteAdmin(String id) async {
    await FirebaseFirestore.instance.collection('users').doc(id).delete();
  }

  // uodate admin
  Future updateAdmin(String id, String? name, String? email, String? phone,
      String? photo) async {
    await FirebaseFirestore.instance.collection('users').doc(id).update({
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (photo != null) 'photo': photo
    });
  }
}
