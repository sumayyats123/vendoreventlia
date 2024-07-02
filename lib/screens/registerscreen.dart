import 'package:flutter/material.dart';
import 'package:vendoreventlia/repo/repo.dart';
import 'package:vendoreventlia/screens/loginscreen.dart';
import 'package:vendoreventlia/widgets/textfield.dart';

class VendorRegisterScreen extends StatefulWidget {
  const VendorRegisterScreen({Key? key}) : super(key: key);

  @override
  State<VendorRegisterScreen> createState() => _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _registerVendor() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _authService.registerVendor(
          emailController.text.trim(),
          passwordController.text.trim(),
          nameController.text,
          phoneController.text,
        );

        emailController.clear();
        passwordController.clear();
        nameController.clear();
        phoneController.clear();

        _showSnackbar(context, 'Vendor registered successfully!');

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => VendorLoginScreen()));
      } catch (e) {
        _showSnackbar(context, 'Failed to register: ${e.toString()}');
      }
    } else {
      _showSnackbar(context, 'Please correct the errors in the form');
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter an email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    } else if (value.contains(' ')) {
      return 'Password should not contain spaces';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your company name';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    } else if (value.trim().length != 10) {
      return 'Please enter a 10-digit valid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 3, 60),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Vendor Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Register as Vendor",
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
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        obscureText: true,
                        controller: passwordController,
                        hintText: 'Enter Password',
                        validator: _validatePassword,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: nameController,
                        hintText: 'Enter Company Name',
                        validator: _validateName,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: phoneController,
                        hintText: 'Enter Phone Number',
                        validator: _validatePhone,
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: _registerVendor,
                        child: Container(
                          height: 60,
                          width: 200,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 233, 202, 109),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an Account?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const VendorLoginScreen(),
                              ));
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
