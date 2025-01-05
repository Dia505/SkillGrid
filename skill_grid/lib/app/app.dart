import 'package:flutter/material.dart';
import 'package:skill_grid/core/theme/app_theme.dart';
import 'package:skill_grid/features/home/presentation/view/client/client_dashboard.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ClientDashboard(),
      theme: getApplicationTheme(),
    );
  }
}
