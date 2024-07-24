import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendoreventlia/model/authservice.dart';
import 'package:vendoreventlia/utilties/utilities.dart';
import 'package:vendoreventlia/view/screens/dashboard/vendordisplay.dart';

class VendorLoginController {
  final AuthService _authService = AuthService();

  Future<void> signInWithEmailAndPassword(String email, String password, BuildContext context) async {
  showLoadingIndicator(context); // Show loading indicator
  try {
    UserCredential userCredential = await _authService.signInWithEmailAndPassword(email, password, context);

    if (userCredential.user != null) {
      String uid = userCredential.user!.uid;

      // Debugging: Check if UID is correct
      print('User ID: $uid');

      DocumentSnapshot vendorDoc = await FirebaseFirestore.instance.collection('vendor').doc(uid).get();

      if (vendorDoc.exists) {
        var data = vendorDoc.data() as Map<String, dynamic>;

        if (data['isvendor'] == true) {
          if (data['isBlocked'] == true) {
            showSnackbar(context, 'Your account has been blocked by the admin.');
            return;
          }

          if (data['isDetailsAdded'] == true) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => VendorDisplayPage(vendorId: uid)));
          } else {
            Navigator.of(context).pushReplacementNamed('/vendorDetails');
          }
        } else {
          showSnackbar(context, 'You do not have vendor access.');
        }
      } else {
        showSnackbar(context, 'Vendor document does not exist.');
      }
    } else {
      showSnackbar(context, 'Failed to sign in: User not found.');
    }
  } on FirebaseAuthException catch (e) {
    _handleFirebaseAuthException(e, context);
  } catch (e) {
    showSnackbar(context, 'An unexpected error occurred.');
  } finally {
    hideLoadingIndicator(context); // Hide loading indicator
  }
}


  void _handleFirebaseAuthException(FirebaseAuthException e, BuildContext context) {
    String errorMessage;
    switch (e.code) {
      case 'invalid-email':
        errorMessage = 'The email address is not valid.';
        break;
      case 'user-disabled':
        errorMessage = 'The user has been disabled.';
        break;
      case 'user-not-found':
        errorMessage = 'No user found for the provided email.';
        break;
      case 'wrong-password':
        errorMessage = 'The password is incorrect.';
        break;
      default:
        errorMessage = 'Failed to sign in: ${e.message}';
    }
    showSnackbar(context, errorMessage);
  }

  void showLoadingIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void hideLoadingIndicator(BuildContext context) {
    Navigator.of(context).pop();
  }
}