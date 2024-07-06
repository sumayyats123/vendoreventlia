
import 'package:flutter/material.dart';
import 'package:vendoreventlia/model/vendordetailes.dart';
import 'package:vendoreventlia/view/screens/dashboard/vendorservice.dart';

class VendorDisplayPage extends StatelessWidget {
  final String vendorId;

  const VendorDisplayPage({Key? key, required this.vendorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 3, 60),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Vendor Register"),
      ),
      body: FutureBuilder<VendorDetails>(
        future: VendorService().getVendorDetails(vendorId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Vendor not found'));
          } else {
            VendorDetails vendor = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(vendor.imageUrl, height: 200, width: 200, fit: BoxFit.cover),
                  ),
                  SizedBox(height: 16),
                  Text(
                    vendor.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Contact: ${vendor.contact}'),
                  SizedBox(height: 8),
                  Text('Address: ${vendor.address}'),
                  SizedBox(height: 16),
                  Text(
                    'Work Images',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: vendor.workImages.length,
                    itemBuilder: (context, index) {
                      return Image.network(vendor.workImages[index], fit: BoxFit.cover);
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}