import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
         colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: Scaffold(
        appBar: AppBar(
          title : Text('Expense Tracker'),
          ),
          body: Center(
            child: Text('Expense Tracker is alive!'),
          ),
      ),
    );
  }

}