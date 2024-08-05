import 'package:flutter/material.dart';

class AvailableSlotsScreen extends StatelessWidget {
  const AvailableSlotsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Slots'),
      ),
      body: Center(
        child: const Text('Available Slots Content'),
      ),
    );
  }
}
