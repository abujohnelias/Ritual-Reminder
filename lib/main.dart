import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ritual_reminder/views/home/home_page.dart';

void main() async {
  //initialize
  await Hive.initFlutter();

  //open box
   await Hive.openBox("Habit_Database");

  //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const HomePage(),
    );
  }
}
