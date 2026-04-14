import 'package:flutter/material.dart';

import 'core/features/quiz/presentation/screens/quiz_screen.dart';

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz project',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const QuizScreen(),
    );
  }
}
