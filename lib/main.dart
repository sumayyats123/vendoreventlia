import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vendoreventlia/view/screens/splashscreen.dart';
import 'package:vendoreventlia/view/widgets/themeconfi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print("Firebase initialized successfully");
  } catch (e) {
    print("Firebase initialization failed: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    theme: ThemeConfig.darkTheme,
    );
  }
}