import 'package:flutter/material.dart';
import 'package:vendoreventlia/controller/registercontroller.dart';
import 'package:vendoreventlia/view/screens/loginscreen.dart';
import 'package:vendoreventlia/view/widgets/textformfield.dart';

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
  final VendorRegisterController _vendorRegisterController = VendorRegisterController();
  bool _showErrors = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            autovalidateMode: _showErrors ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
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
                          controller: nameController,
                          hintText: 'Enter Name',
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (!_showErrors) return null;
                            return _vendorRegisterController.validateName(value);
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: phoneController,
                          hintText: 'Enter Phone Number',
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (!_showErrors) return null;
                            return _vendorRegisterController.validatePhone(value);
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: emailController,
                          hintText: 'Enter Email',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (!_showErrors) return null;
                            return _vendorRegisterController.validateEmail(value);
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          obscureText: true,
                          controller: passwordController,
                          hintText: 'Enter Password',
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (!_showErrors) return null;
                            return _vendorRegisterController.validatePassword(value);
                          },
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _showErrors = true;
                            });
                            if (_formKey.currentState!.validate()) {
                              _vendorRegisterController.registerVendor(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                nameController.text,
                                phoneController.text,
                                context,
                              );
                            } else {
                              _vendorRegisterController.showSnackbar(
                                context,
                                'Please correct the errors in the form',
                                Colors.red,
                              );
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const VendorLoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
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
      ),
    );
  }
}
