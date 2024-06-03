import 'package:flutter/material.dart';

class ViewAllBooking extends StatefulWidget {
  const ViewAllBooking({super.key});

  @override
  State<ViewAllBooking> createState() => _ViewAllBookingState();
}

class _ViewAllBookingState extends State<ViewAllBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
