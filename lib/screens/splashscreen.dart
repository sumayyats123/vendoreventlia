import 'package:vendoreventlia/screens/loginscreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/w1.png"),
            const SizedBox(height: 100),
             GestureDetector(
               onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>  VendorLoginScreen()),
                );
              },
               child: const Text(
                "Vendor Panel",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                ),
                         ),
             ),
          ],
        ),
      ),
    );
  }
}

