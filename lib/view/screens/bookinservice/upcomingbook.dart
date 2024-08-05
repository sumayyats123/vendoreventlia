import 'package:flutter/material.dart';

class UpcomingBookingsScreen extends StatelessWidget {
  const UpcomingBookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Bookings'),
      ),
      body: Center(
        child: const Text('Upcoming Bookings Content'),
      ),
    );
  }
}
