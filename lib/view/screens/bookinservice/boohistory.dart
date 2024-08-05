import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendoreventlia/view/screens/bookinservice/bookingservices.dart'; // Import your service class

class BookingHistoryScreen extends StatefulWidget {
  final String vendorId;

  const BookingHistoryScreen({Key? key, required this.vendorId}) : super(key: key);

  @override
  _BookingHistoryScreenState createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  late Future<List<Map<String, dynamic>>> _bookingHistory;

  @override
  void initState() {
    super.initState();
    _bookingHistory = BookingService().getBookingHistory(widget.vendorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _bookingHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No bookings found.'));
          } else {
            final bookings = snapshot.data!;
            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                final bookingDate = (booking['date'] as Timestamp).toDate(); // Assuming you store date as a Timestamp
                final bookingDetails = booking['details'] ?? 'No details available';

                return ListTile(
                  title: Text('Booking on ${bookingDate.toLocal()}'),
                  subtitle: Text(bookingDetails),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle tap to view more details if necessary
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
