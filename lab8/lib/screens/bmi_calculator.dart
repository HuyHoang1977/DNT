import 'package:flutter/material.dart';
import '../widgets/gender.dart';
import '../widgets/height.dart';
import '../widgets/weight_age.dart';
import '../widgets/calculate_button.dart';
import '../widgets/result.dart';

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  String selectedGender = "Male";
  double height = 160;
  int weight = 60;
  int age = 25;
  String result = "";
  String category = "";

  void calculateBMI() {
    double bmi = weight / ((height / 100) * (height / 100));
    setState(() {
      result = "Your BMI is: ${bmi.toStringAsFixed(1)}";
      if (bmi < 18.5) {
        category = "Underweight";
      } else if (bmi >= 18.5 && bmi < 24.9) {
        category = "Normal";
      } else {
        category = "Overweight";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
        backgroundColor: Colors.orange,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GenderSelection(
              selectedGender: selectedGender,
              onGenderSelected: (gender) {
                setState(() {
                  selectedGender = gender;
                });
              },
            ),
            const SizedBox(height: 20),
            HeightInputSlider(
              height: height,
              onHeightChanged: (newHeight) {
                setState(() {
                  height = newHeight;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                WeightAgeInput(
                  label: "Weight",
                  value: weight,
                  onValueChanged: (newValue) {
                    setState(() {
                      weight = newValue;
                    });
                  },
                ),
                const SizedBox(width: 10),
                WeightAgeInput(
                  label: "Age",
                  value: age,
                  onValueChanged: (newValue) {
                    setState(() {
                      age = newValue;
                    });
                  },
                ),
              ],
            ),
            const Spacer(),
            ResultDisplay(
              result: result,
              category: category,
            ),
            const SizedBox(height: 20),
            CalculateButton(
              onPressed: calculateBMI,
            ),
          ],
        ),
      ),
    );
  }
}
