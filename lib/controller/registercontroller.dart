import 'package:flutter/material.dart';
import 'package:vendoreventlia/model/authservice.dart';
import 'package:vendoreventlia/view/screens/loginscreen.dart';

class VendorRegisterController {
  final AuthService _authService = AuthService();

  Future<void> registerVendor(
    String email,
    String password,
    String name,
    String phone,
    BuildContext context,
  ) async {
    try {
      await _authService.registerVendor(email, password, name, phone);

      showSnackbar(context, 'Vendor registered successfully!');

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>  VendorLoginScreen()));
    } catch (e) {
      showSnackbar(context, 'Failed to register: ${e.toString()}');
    }
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter an email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    } else if (value.contains(' ')) {
      return 'Password should not contain spaces';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your company name';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    } else if (value.trim().length != 10) {
      return 'Please enter a 10-digit valid phone number';
    }
    return null;
  }
}