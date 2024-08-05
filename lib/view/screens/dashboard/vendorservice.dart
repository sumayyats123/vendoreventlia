import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendoreventlia/model/vendordetailes.dart';

class VendorService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<VendorDetails> getVendorDetails(String vendorId) async {
    try {
      var snapshot = await _db.collection('vendor').doc(vendorId).get();
      if (snapshot.exists) {
        return VendorDetails.fromFirestore(snapshot);
      } else {
        throw Exception('Vendor not found');
      }
    } catch (e) {
      print("Failed to fetch vendor details: $e");
       throw Exception('Failed to fetch vendor details: $e');
    }
  }
}
