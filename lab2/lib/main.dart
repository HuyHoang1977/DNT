import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCardScreen(),
    );
  }
}

class MyCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MiCard'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 8,
          margin: EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://p5.itc.cn/images01/20210513/6d38bfccf1154d4fac969be5cbc1ee4f.jpeg'), // Replace with your image
                ),
                SizedBox(height: 10),
                Text(
                  'Cam Orange',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                Text(
                  '1234',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.teal.shade700,
                  ),
                ),
                Divider(
                  color: Colors.teal.shade200,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                ListTile(
                  leading: Icon(Icons.phone, color: Colors.teal),
                  title: Text('+084 456 7890'),
                ),
                ListTile(
                  leading: Icon(Icons.email, color: Colors.teal),
                  title: Text('orangejui_e@gmail.com'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
