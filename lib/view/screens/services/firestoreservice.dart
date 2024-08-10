import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendoreventlia/view/screens/services/servicemodel.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ServiceItem>> fetchServices(String categoryId) async {
    try {
      final querySnapshot = await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection('services')
          .get();

      return querySnapshot.docs
          .map((doc) => ServiceItem.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error fetching services: $e');
    }
  }

  Future<void> addService(String categoryId, ServiceItem service) async {
    try {
      await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection('services')
          .doc(service.id)
          .set(service.toMap());
    } catch (e) {
      throw Exception('Error adding service: $e');
    }
  }

  Future<void> updateService(String categoryId, ServiceItem service) async {
    try {
      await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection('services')
          .doc(service.id)
          .update(service.toMap());
    } catch (e) {
      throw Exception('Error updating service: $e');
    }
  }

  Future<void> deleteService(String categoryId, String serviceId) async {
    try {
      await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection('services')
          .doc(serviceId)
          .delete();
    } catch (e) {
      throw Exception('Error deleting service: $e');
    }
  }
}
