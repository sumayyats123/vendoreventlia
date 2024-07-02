import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendoreventlia/screens/homescreen.dart';
import 'package:vendoreventlia/screens/registerscreen.dart';
import 'package:vendoreventlia/widgets/textfield.dart';

class VendorLoginScreen extends StatefulWidget {
  const VendorLoginScreen({Key? key}) : super(key: key);

  @override
  State<VendorLoginScreen> createState() => _VendorLoginScreenState();
}

class _VendorLoginScreenState extends State<VendorLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;
        print("User signed in with UID: $uid");

        DocumentSnapshot vendorDoc = await FirebaseFirestore.instance.collection('vendor').doc(uid).get();

        if (vendorDoc.exists) {
          var data = vendorDoc.data() as Map<String, dynamic>;
          print("Vendor document data: $data");

          if (data['isvendor'] == true) {
            _showSnackbar(context, 'Successfully logged in.');
            emailController.clear();
            passwordController.clear();
            Navigator.of(context).push(MaterialPageRoute(builder: ((context) => HomeScreen())));
          } else {
            _showSnackbar(context, 'You do not have vendor access.');
          }
        } else {
          _showSnackbar(context, 'Vendor document does not exist.');
        }
      } else {
        _showSnackbar(context, 'Failed to sign in: User not found.');
      }
    } on FirebaseAuthException catch (e) {
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
      print(errorMessage);
      _showSnackbar(context, errorMessage);
    } catch (e) {
      print("Error: $e");
      _showSnackbar(context, 'An unexpected error occurred.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Vendor Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: emailController,
                  hintText: 'Enter Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  obscureText: true,
                  controller: passwordController,
                  hintText: 'Enter Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _signInWithEmailAndPassword();
                    } else {
                      _showSnackbar(context, 'Please correct the errors in the form');
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const VendorRegisterScreen()),
                        );
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
