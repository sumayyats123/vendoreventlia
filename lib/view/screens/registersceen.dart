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
                        validator: _vendorRegisterController.validateEmail,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        obscureText: true,
                        controller: passwordController,
                        hintText: 'Enter Password',
                        validator: _vendorRegisterController.validatePassword,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: nameController,
                        hintText: 'Enter Company Name',
                        validator: _vendorRegisterController.validateName,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: phoneController,
                        hintText: 'Enter Phone Number',
                        validator: _vendorRegisterController.validatePhone,
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
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
                            );
                          }
                        },
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

