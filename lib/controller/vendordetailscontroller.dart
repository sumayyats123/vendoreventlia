
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class VendorDetailsController {
//   Future<void> addVendorDetails(
//     String address,
//     String businessHours,
//     String services,
//     BuildContext context,
//   ) async {
//     try {
//       String uid = FirebaseAuth.instance.currentUser!.uid;

//       await FirebaseFirestore.instance.collection('vendor').doc(uid).update({
//         'address': address,
//         'businessHours': businessHours,
//         'services': services,
//       });

//       showSnackbar(context, 'Vendor details added successfully!');
//     } catch (e) {
//       showSnackbar(context, 'Failed to add vendor details: ${e.toString()}');
//     }
//   }

//   void showSnackbar(BuildContext context, String message) {
//     final snackBar = SnackBar(content: Text(message));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }