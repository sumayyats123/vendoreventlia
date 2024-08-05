// import 'package:flutter/material.dart';
// import 'package:vendoreventlia/controller/vendordetailscontroller.dart';
// import 'package:vendoreventlia/view/widgets/textformfield.dart';

// class VendorDetailsScreen extends StatefulWidget {
//   const VendorDetailsScreen({Key? key}) : super(key: key);

//   @override
//   _VendorDetailsScreenState createState() => _VendorDetailsScreenState();
// }

// class _VendorDetailsScreenState extends State<VendorDetailsScreen> {
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController businessHoursController = TextEditingController();
//   final TextEditingController servicesController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();
//   final VendorDetailsController _vendorDetailsController = VendorDetailsController();

//   @override
//   void dispose() {
//     addressController.dispose();
//     businessHoursController.dispose();
//     servicesController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Vendor Details"),
//         backgroundColor: const Color.fromARGB(255, 6, 3, 60),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 CustomTextFormField(
//                   controller: addressController,
//                   hintText: 'Enter Address',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter an address';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 CustomTextFormField(
//                   controller: businessHoursController,
//                   hintText: 'Enter Business Hours',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter business hours';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 CustomTextFormField(
//                   controller: servicesController,
//                   hintText: 'Enter Services Offered',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter services offered';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _vendorDetailsController.addVendorDetails(
//                         addressController.text.trim(),
//                         businessHoursController.text.trim(),
//                         servicesController.text.trim(),
//                         context,
//                       );
//                     } else {
//                       _vendorDetailsController.showSnackbar(
//                         context,
//                         'Please correct the errors in the form',
//                       );
//                     }
//                   },
//                   child: const Text('Submit'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
