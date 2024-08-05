import 'package:flutter/material.dart';
import 'package:vendoreventlia/model/vendordetailes.dart';
import 'package:vendoreventlia/view/screens/bookinservice/booingmanagement.dart';
import 'package:vendoreventlia/view/screens/dashboard/edit.dart';
import 'package:vendoreventlia/view/screens/dashboard/vendorservice.dart';

class VendorDisplayPage extends StatefulWidget {
  final String vendorId;

  const VendorDisplayPage({Key? key, required this.vendorId}) : super(key: key);

  @override
  _VendorDisplayPageState createState() => _VendorDisplayPageState();
}

class _VendorDisplayPageState extends State<VendorDisplayPage> {
  late Future<VendorDetails> _vendorDetails;

  @override
  void initState() {
    super.initState();
    _fetchVendorDetails();
  }

  void _fetchVendorDetails() {
    setState(() {
      _vendorDetails = VendorService().getVendorDetails(widget.vendorId);
    });
  }

  void _onDropdownMenuItemSelected(String value) {
    switch (value) {
      case 'Change Profile':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditProfileScreen(vendorId: widget.vendorId),
          ),
        ).then((updatedName) {
          if (updatedName != null) {
            setState(() {
              _fetchVendorDetails();
            });
          }
        });
        break;
        case 'Booking Management':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingManagementScreen(vendorId: widget.vendorId),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _onDropdownMenuItemSelected,
            itemBuilder: (BuildContext context) {
              return [
                'Change Profile',
                'Services',
                'Booking Management',
                'Notification',
                'Pricing',
                'Settings',
              ].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: FutureBuilder<VendorDetails>(
        future: _vendorDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Vendor not found'));
          } else {
            VendorDetails vendor = snapshot.data!;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          vendor.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(child: Text('Error loading image'));
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vendor.name,
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            const Row(
                              children: [
                                Icon(Icons.location_on, size: 24.0, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text(
                                  'Location'  ,
                                  style: TextStyle(
                          
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text('Contact: ${vendor.phone}'),
                            const SizedBox(height: 16),
                         
                          ],
                        ),
                      ),
                      ElevatedButton( 
                        onPressed: () {
                          // Implement chat functionality here
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Chat with User',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  vendor.workImages.isEmpty
                      ? const Text('No work images available')
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                return const Center(child: Text('Error loading image'));
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
