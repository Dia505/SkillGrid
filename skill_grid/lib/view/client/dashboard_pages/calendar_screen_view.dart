import 'package:flutter/material.dart';

class CalendarScreenView extends StatefulWidget {
  const CalendarScreenView({super.key});

  @override
  State<CalendarScreenView> createState() => _CalendarScreenViewState();
}

class _CalendarScreenViewState extends State<CalendarScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Calendar Screen"),
      ),
    );
  }
}