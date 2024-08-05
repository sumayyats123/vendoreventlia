// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:vendoreventlia/model/vendordetailes.dart';

// class VendorProvider extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   User? get currentUser => _auth.currentUser;
//   bool _isLoading = false;
//   String? _errorMessage;

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;

//   void setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   void setError(String? message) {
//     _errorMessage = message;
//     notifyListeners();
//   }

//   Future<VendorDetails?> fetchVendorDetails(String uid) async {
//     setLoading(true);
//     setError(null);
//     try {
//       DocumentSnapshot doc = await _firestore.collection('vendor').doc(uid).get();
//       if (doc.exists) {
//         return VendorDetails.fromFirestore(doc);
//       } else {
//         throw Exception('Vendor not found');
//       }
//     } catch (e) {
//       setError('Error fetching vendor details: $e');
//       print('Error fetching vendor details: $e');
//       throw e;
//     } finally {
//       setLoading(false);
//     }
//   }
// }
