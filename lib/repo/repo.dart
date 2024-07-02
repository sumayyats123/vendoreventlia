import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      print("Error signing in: $e");
      throw e;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  bool isUserLoggedIn() {
    return _auth.currentUser != null;
  }

  String getCurrentUserId() {
    return _auth.currentUser?.uid ?? '';
  }

  Future<void> registerVendor(String email, String password, String name, String phone) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
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
          'isvendor': true, // additional field indicating vendor status
        });
      }
    } catch (e) {
      print("Error registering vendor: $e");
      throw e;
    }
  }
}

