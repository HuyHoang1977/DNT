import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orange Dicce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        useMaterial3: true,
      ),
      home: const DiccePage(title: 'Orange Dicce'),
    );
  }
}

class DiccePage extends StatefulWidget {
  const DiccePage({super.key, required this.title});
  final String title;

  @override
  State<DiccePage> createState() => _DiccePageState();
}

class _DiccePageState extends State<DiccePage> {
  int leftDiceNum = 1;
  int rightDiceNum = 1;

  void _dice() {
    setState(() {
      leftDiceNum = Random().nextInt(6) +1;
      rightDiceNum = Random().nextInt(6) +1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Căn giữa các phần tử
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: _dice, // Gọi hàm _dice khi nhấn
                child: Image.asset(
                  'images/dice$leftDiceNum.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: _dice, // Gọi hàm _dice khi nhấn
                child: Image.asset(
                  'images/dice$rightDiceNum.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
