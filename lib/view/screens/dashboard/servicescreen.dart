// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:vendoreventlia/view/screens/dashboard/vendorservice.dart';

// class AddServiceScreen extends StatefulWidget {
//   const AddServiceScreen({Key? key}) : super(key: key);

//   @override
//   State<AddServiceScreen> createState() => _AddServiceScreenState();
// }

// class _AddServiceScreenState extends State<AddServiceScreen> {
//   final TextEditingController serviceNameController = TextEditingController();
//   final TextEditingController serviceDescriptionController = TextEditingController();
//   final TextEditingController servicePriceController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final VendorService _vendorService = VendorService();

//   @override
//   void dispose() {
//     serviceNameController.dispose();
//     serviceDescriptionController.dispose();
//     servicePriceController.dispose();
//     super.dispose();
//   }

//   Future<void> _addService() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         User? user = _auth.currentUser;
//         if (user != null) {
//           await _vendorService.addService(
//             user.uid,
//             serviceNameController.text.trim(),
//             serviceDescriptionController.text.trim(),
//             double.parse(servicePriceController.text.trim()),
//           );

//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Service added successfully!')),
//           );

//           Navigator.of(context).pop();
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error adding service: ${e.toString()}')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Service'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: serviceNameController,
//                 decoration: const InputDecoration(labelText: 'Service Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter service name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               TextFormField(
//                 controller: serviceDescriptionController,
//                 decoration: const InputDecoration(labelText: 'Service Description'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter service description';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               TextFormField(
//                 controller: servicePriceController,
//                 decoration: const InputDecoration(labelText: 'Service Price'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter service price';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 32.0),
//               ElevatedButton(
//                 onPressed: _addService,
//                 child: const Text('Add Service'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
