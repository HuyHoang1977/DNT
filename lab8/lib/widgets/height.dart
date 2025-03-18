import 'package:flutter/material.dart';

class HeightInputSlider extends StatelessWidget {
  final double height;
  final ValueChanged<double> onHeightChanged;

  const HeightInputSlider({
    required this.height,
    required this.onHeightChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Height (cm)", style: TextStyle(fontSize: 18, color: Colors.white)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Slider(
                value: height,
                min: 100,
                max: 220,
                onChanged: onHeightChanged,
                activeColor: Colors.pink,
                inactiveColor: Colors.grey,
              ),
            ),
            Text("${height.toStringAsFixed(0)} cm", style: const TextStyle(color: Colors.white)),
          ],
        ),
      ],
    );
  }
}
