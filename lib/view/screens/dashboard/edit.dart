import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendoreventlia/model/vendordetailes.dart';
import 'package:vendoreventlia/view/screens/dashboard/vendorservice.dart';

class EditProfileScreen extends StatefulWidget {
  final String vendorId;

  const EditProfileScreen({Key? key, required this.vendorId}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late Future<VendorDetails> _futureVendorDetails;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureVendorDetails = VendorService().getVendorDetails(widget.vendorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: FutureBuilder<VendorDetails>(
        future: _futureVendorDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Failed to load vendor details: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No vendor details found'));
          }

          final vendor = snapshot.data!;
          _nameController.text = vendor.name;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Set the background color to green
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await FirebaseFirestore.instance.collection('vendor').doc(widget.vendorId).update({
          'name': _nameController.text,
        });

        // Show success snackbar
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Successfully edited profile'),
              backgroundColor: Colors.green, // Set the background color to green
            ),
          );
        }

        if (Navigator.canPop(context)) {
          Navigator.pop(context, _nameController.text);
        }
      } catch (e) {
        print('Failed to update profile: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update profile')),
          );
        }
      }
    } else {
      print('Form validation failed');
    }
  }
}
