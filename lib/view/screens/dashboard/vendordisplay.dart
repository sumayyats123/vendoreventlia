import 'package:flutter/material.dart';
import 'package:vendoreventlia/model/vendordetailes.dart';
import 'package:vendoreventlia/view/screens/dashboard/vendorservice.dart';

class VendorDisplayPage extends StatelessWidget {
  final String vendorId;

  const VendorDisplayPage({Key? key, required this.vendorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (vendorId.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 6, 3, 60),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text("Vendor Register"),
        ),
        body: Center(child: Text('Invalid Vendor ID')),
      );
    }

    return Scaffold(
      appBar: AppBar(
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

            // Debugging: Print the workImages list to check if it is being fetched correctly
            print('Work Images: ${vendor.workImages}');

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      vendor.imageUrl,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(child: Text('Error loading image'));
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    vendor.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Contact: ${vendor.phone}'),
                  SizedBox(height: 8),
                  Text('Address: ${vendor.address}'),
                  SizedBox(height: 16),
                  Text('Work Images:', style: Theme.of(context).textTheme.headline6),
                  SizedBox(height: 8),

                  // Add check for empty workImages list
                  vendor.workImages.isEmpty
                      ? Text('No work images available')
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemCount: vendor.workImages.length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              vendor.workImages[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(child: Text('Error loading image'));
                              },
                            );
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

