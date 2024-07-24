import 'package:flutter/material.dart';
import 'package:vendoreventlia/model/authservice.dart';

class VendorLoginScreen extends StatefulWidget {
  @override
  _VendorLoginScreenState createState() => _VendorLoginScreenState();
}

class _VendorLoginScreenState extends State<VendorLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  void _toggleLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      _toggleLoading(true);
      try {
        await _authService.signInWithEmailAndPassword(
          emailController.text.trim(),
          passwordController.text.trim(),
          context,
        );
      } catch (error) {
        _showSnackbar('An unexpected error occurred.');
      } finally {
        _toggleLoading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vendor Login"),
        backgroundColor: const Color.fromARGB(255, 6, 3, 60),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleSignIn,
                child: _isLoading 
                  ? const CircularProgressIndicator() 
                  : const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
