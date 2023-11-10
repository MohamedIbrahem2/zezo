// reset password service
import 'package:firebase_auth/firebase_auth.dart';
// reset password view

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_model/auth_view_model.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({Key? key}) : super(key: key);
  final AuthViewModel _authViewModel = Get.put(AuthViewModel());

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await ResetPasswordService()
                      .resetPassword(_emailController.text.trim());
                  Get.back();
                },
                child: const Text('Reset Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResetPasswordService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // forgot password

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Error resetting password: $e');
    }
  }
}


// forget password service


