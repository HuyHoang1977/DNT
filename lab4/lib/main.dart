import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic 8 Ball',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const BallPage(title: 'Magic 8Ball Page'),
    );
  }
}

class BallPage extends StatefulWidget {
  const BallPage({super.key, required this.title});
  final String title;

  @override
  State<BallPage> createState() => _BallPageState();
}

class _BallPageState extends State<BallPage> {
  int _ballNum = 1;

  void _randomBall() {
    setState(() {
      _ballNum = Random().nextInt(5)+1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: TextButton(
            onPressed: _randomBall,
            child: Image.asset('images/ball$_ballNum.png'),
        )
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
