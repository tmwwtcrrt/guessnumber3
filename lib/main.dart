import 'package:flutter/material.dart';
import 'package:guessnumber3/guess/guess_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GUESS THE NUMBER',
      theme: ThemeData(

        primarySwatch: Colors.purple,
      ),
      home: const GuessPage(),
    );
  }
}