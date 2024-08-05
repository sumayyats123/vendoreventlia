import 'package:flutter/material.dart';
import 'package:vendoreventlia/view/screens/bookinservice/availablebook.dart';
import 'package:vendoreventlia/view/screens/bookinservice/boohistory.dart';
import 'package:vendoreventlia/view/screens/bookinservice/calender.dart';
import 'package:vendoreventlia/view/screens/bookinservice/upcomingbook.dart';

class BookingManagementScreen extends StatelessWidget {
  final String vendorId;

  const BookingManagementScreen({Key? key, required this.vendorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Management'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Booking History'),
            leading: const Icon(Icons.history),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  BookingHistoryScreen(vendorId: vendorId,),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Upcoming Bookings'),
            leading: const Icon(Icons.event_note),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpcomingBookingsScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Available Slots'),
            leading: const Icon(Icons.access_time),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AvailableSlotsScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Calendar'),
            leading: const Icon(Icons.calendar_today),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CalendarScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
