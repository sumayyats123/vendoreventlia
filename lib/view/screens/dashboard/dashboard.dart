import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vendoreventlia/view/screens/dashboard/aboutscreen.dart';
import 'package:vendoreventlia/view/screens/dashboard/detailesscreen.dart';
import 'package:vendoreventlia/view/screens/dashboard/helpandsupport.dart';
import 'package:vendoreventlia/view/screens/dashboard/historyscreen.dart';
import 'package:vendoreventlia/view/screens/dashboard/privacyandpolicy.dart';
import 'package:vendoreventlia/view/screens/dashboard/profilescreen.dart';
import 'package:vendoreventlia/view/screens/loginscreen.dart';

class VendorDashboardScreen extends StatelessWidget {
  const VendorDashboardScreen({Key? key}) : super(key: key);

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) =>  VendorLoginScreen()),
                  (route) => false,
                );
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 3, 60),
        title: Text("Vendor Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              _showLogoutConfirmationDialog(context);
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.person, color: Colors.white),
            title: Text('Profile', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to Profile Screen
              _navigateTo(context, ProfileScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.history, color: Colors.white),
            title: Text('History', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to History Screen
              _navigateTo(context, HistoryScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: Colors.white),
            title: Text('About Us', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to About Us Screen
              _navigateTo(context, Aboutscreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.help, color: Colors.white),
            title: Text('Help and Support', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to Help and Support Screen
              _navigateTo(context, HelpAndSupportScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip, color: Colors.white),
            title: Text('Privacy and Policy', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to Privacy And Policy Screen
              _navigateTo(context, PrivacyAndPolicyScreen());
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.build, color: Colors.white),
          //   title: Text('Services', style: TextStyle(color: Colors.white)),
          //   onTap: () {
          //     // Navigate to Services Screen
          //     _navigateTo(context, ServicesScreen());
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.add, color: Colors.white),
            title: Text('Add Vendor Details', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to Vendor Details Screen
              _navigateTo(context, VendorDetailsScreen());
            },
          ),
        ],
      ),
    );
  }
}
