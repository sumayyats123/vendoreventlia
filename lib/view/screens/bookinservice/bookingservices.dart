import 'package:cloud_firestore/cloud_firestore.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getBookingHistory(String vendorId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('vendors')
          .doc(vendorId)
          .collection('bookings')
          .orderBy('date', descending: true) // Assuming you have a date field
          .get();

      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error fetching booking history: $e');
      return [];
    }
  }
}
