import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  final String result;
  final String category;

  const ResultDisplay({
    required this.result,
    required this.category,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(result, style: const TextStyle(color: Colors.white, fontSize: 24)),
        Text(category, style: const TextStyle(color: Colors.grey, fontSize: 18)),
      ],
    );
  }
}
