import 'package:flutter/material.dart';

class WeightAgeInput extends StatelessWidget {
  final String label;
  final int value;
  final ValueChanged<int> onValueChanged;

  const WeightAgeInput({
    required this.label,
    required this.value,
    required this.onValueChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 18, color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => onValueChanged(value - 1),
                icon: const Icon(Icons.remove, color: Colors.white),
              ),
              Text(value.toString(), style: const TextStyle(color: Colors.white, fontSize: 24)),
              IconButton(
                onPressed: () => onValueChanged(value + 1),
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
