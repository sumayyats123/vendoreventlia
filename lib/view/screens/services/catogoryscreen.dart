import 'package:flutter/material.dart';
import 'package:vendoreventlia/view/screens/services/categorymodel.dart';
import 'package:vendoreventlia/view/screens/services/servicelistscreen.dart';

class VendorCategoriesScreen extends StatelessWidget {
  final String vendorId; // Accept vendorId in the constructor

  VendorCategoriesScreen({Key? key, required this.vendorId}) : super(key: key);

  final List<ServiceCategory> categories = [
    ServiceCategory(id: '1', name: 'Photography'),
    ServiceCategory(id: '2', name: 'Videography'),
    ServiceCategory(id: '3', name: 'Decoration'),
    ServiceCategory(id: '4', name: 'Makeup'),
    ServiceCategory(id: '5', name: 'Catering'),

    // Add more categories as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            title: Text(category.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ServicesListScreen(
                    categoryId: category.id,
                    vendorId: vendorId, // Pass vendorId to ServicesListScreen
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
