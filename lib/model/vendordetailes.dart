// import 'package:cloud_firestore/cloud_firestore.dart';

// class VendorDetails {
//   final String uid;
//   final String name;
//   final String phone;
//   final String email;
//   final String imageUrl;
//   final List<String> workImage;
//   final Timestamp createdAt;
//   final bool isVendor;

//   VendorDetails({
//     required this.uid,
//     required this.name,
//     required this.phone,
//     required this.email,
//     required this.imageUrl,
//     required this.workImage,
//     required this.createdAt,
//     required this.isVendor,
//   });

//   factory VendorDetails.fromFirestore(Map<String, dynamic> data) {
//     return VendorDetails(
//       uid: data['uid'] ?? '',
//       name: data['name'] ?? '',
//       phone: data['phone'] ?? '',
//       email: data['email'] ?? '',
//       imageUrl: data['imageUrl'] ?? '',
//       workImage: List<String>.from(data['workImage'] ?? []),
//       createdAt: data['createdAt'] ?? Timestamp.now(),
//       isVendor: data['isvendor'] ?? false,
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class VendorDetails {
  final String uid;
  final String email;
  final String name;
  final String phone;
  final String address;
  final String imageUrl;
  final String profilePictureUrl;
  final List<String> workImages;

  VendorDetails({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
    required this.imageUrl,
    required this.workImages,
    required this.profilePictureUrl
  });

  factory VendorDetails.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return VendorDetails(
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      address: data['address'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      workImages: List<String>.from(data['workImage'] ?? []),  
      profilePictureUrl: data['profilePictureUrl'] ?? '',
      // Ensure correct field name
    );
  }
}
