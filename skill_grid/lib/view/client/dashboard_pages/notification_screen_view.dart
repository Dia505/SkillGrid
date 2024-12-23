import 'package:flutter/material.dart';

class NotificationScreenView extends StatefulWidget {
  const NotificationScreenView({super.key});

  @override
  State<NotificationScreenView> createState() => _NotificationScreenViewState();
}

class _NotificationScreenViewState extends State<NotificationScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Notification Screen"),
      ),
    );
  }
}