import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/quiz/presentation/blocs/quiz_cubit.dart';
import 'quiz_app.dart';

void main() {
  runApp(
    BlocProvider(create: (context) => QuizCubit(), child: const QuizApp()),
  );
}
