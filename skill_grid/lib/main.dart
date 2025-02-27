import 'package:flutter/material.dart';
import 'package:skill_grid/app/app.dart';
import 'package:skill_grid/app/di/di.dart';
import 'package:skill_grid/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await initDependencies();
  
  runApp(const MyApp());
}

 