import 'package:flutter/material.dart';
import 'questions.dart';
import 'dart:math';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizz App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const MyHomePage(title: 'Quizz App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _QuizzState();
}

class _QuizzState extends State<MyHomePage> {
  late List<Map<String, dynamic>> selectedQuestions;
  int currentQuestionIndex = 0;
  int correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    _resetQuiz();
  }

  List<Map<String, dynamic>> _generateRandomQuestions() {
    final random = Random();
    return (List<Map<String, dynamic>>.from(allQuestions)..shuffle(random)).take(5).toList();
  }

  void _answerQuestion(String answer) {
    if (answer == selectedQuestions[currentQuestionIndex]['correct']) {
      correctAnswers++;
    }
    setState(() {
      if (currentQuestionIndex < selectedQuestions.length - 1) {
        currentQuestionIndex++;
      } else {
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed!'),
        content: Text('You got $correctAnswers out of ${selectedQuestions.length} correct!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetQuiz();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _resetQuiz() {
    setState(() {
      selectedQuestions = _generateRandomQuestions();
      currentQuestionIndex = 0;
      correctAnswers = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = selectedQuestions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(style: const TextStyle(color: Colors.white , fontWeight: FontWeight.bold),'Question ${currentQuestionIndex + 1}/${selectedQuestions.length}'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              question['question'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ...question['answers'].map<Widget>((answer) => Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white60,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => _answerQuestion(answer),
                child: Text(
                  answer,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}