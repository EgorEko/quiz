import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/common/blocs/quiz_cubit.dart';
import 'core/data/datasources/quiz_local_datasource.dart';
import 'core/data/repositories/quiz_repository_impl.dart';
import 'core/domain/usecases/get_questions.dart';
import 'core/domain/usecases/get_quiz_history.dart';
import 'core/domain/usecases/save_quiz_result.dart';
import 'quiz_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  // Data Layer
  final localDataSource = QuizLocalDataSourceImpl(sharedPreferences);
  final repository = QuizRepositoryImpl(localDataSource);

  // Domain Layer (UseCases)
  final getHistory = GetQuizHistory(repository);
  final saveResult = SaveQuizResult(repository);
  final getQuestions = GetQuestions(repository);

  runApp(
    BlocProvider(
      create: (context) => QuizCubit(
        getQuizHistory: getHistory,
        saveQuizResult: saveResult,
        getQuestions: getQuestions,
      ),
      child: const QuizApp(),
    ),
  );
}
