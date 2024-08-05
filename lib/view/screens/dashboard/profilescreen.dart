import 'package:flutter/material.dart';
import 'package:vendoreventlia/model/vendordetailes.dart';
import 'package:vendoreventlia/view/screens/dashboard/vendorservice.dart';

class ProfileScreen extends StatefulWidget {
  final String vendorId;

  ProfileScreen({required this.vendorId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<VendorDetails> _vendorDetails;

  @override
  void initState() {
    super.initState();
    _vendorDetails = VendorService().getVendorDetails(widget.vendorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<VendorDetails>(
        future: _vendorDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }

          final vendor = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(vendor.profilePictureUrl),
                  ),
                ),
                SizedBox(height: 16),
                Text('Name: ${vendor.name}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Email: ${vendor.email}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Phone: ${vendor.phone}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Address: ${vendor.address}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to edit profile screen
                    },
                    child: Text('Edit Profile'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
