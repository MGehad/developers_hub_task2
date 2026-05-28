import 'package:developers_hub_task2/app.dart';
import 'package:developers_hub_task2/core/services/local_database/local_database.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalDatabase.init();

  runApp(const MyApp());
}
