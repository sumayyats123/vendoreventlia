import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendoreventlia/view/screens/dashboard/vendordisplay.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        DocumentSnapshot vendorDoc = await _firestore.collection('vendor').doc(user.uid).get();
        if (vendorDoc.exists) {
          String vendorId = vendorDoc.id;
          navigateToVendorDetails(context, vendorId);
          return true;
        } else {
          print("Vendor document does not exist");
          return false;
        }
      }
    } catch (e) {
      print("Error signing in: $e");
    }
    return false;
  }

  void navigateToVendorDetails(BuildContext context, String vendorId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => VendorDisplayPage(vendorId: vendorId)),
    );
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error signing out: $e");
      throw Exception("Failed to sign out. Please try again.");
    }
  }

  bool isUserLoggedIn() {
    return _auth.currentUser != null;
  }

  String getCurrentUserId() {
    return _auth.currentUser?.uid ?? '';
  }

  Future<void> registerVendor(
      String email, String password, String name, String phone) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('vendor').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'name': name,
          'phone': phone,
          'createdAt': DateTime.now(),
          'isvendor': true,
          'imageUrl': '',
          'workImages': [],
        });
      }
    } catch (e) {
      print("Error registering vendor: $e");
      throw Exception(
          "Failed to register vendor. Please check the details and try again.");
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Error resetting password: $e");
      throw Exception(
          "Failed to send password reset email. Please try again later.");
    }
  }
}
