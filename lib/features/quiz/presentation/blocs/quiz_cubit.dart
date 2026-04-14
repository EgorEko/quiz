import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/question.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());

  int _currentScore = 0;
  int _currentIndex = 0;

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('quiz_history') ?? [];

    if (history.isNotEmpty) {
      emit(QuizHistoryLoaded(history));
    } else {
      emit(QuizNoHistory());
    }
  }

  void startQuiz() {
    _currentIndex = 0;
    _currentScore = 0;
    emit(QuizInProgress(_currentIndex, 0));
  }

  Future<void> submitAnswer(int selectedIndex) async {
    if (selectedIndex == staticQuestions[_currentIndex].correctAnswerIndex) {
      _currentScore++;
    }

    if (_currentIndex < staticQuestions.length - 1) {
      _currentIndex++;
      emit(QuizInProgress(_currentIndex, _currentScore));
    } else {
      final prefs = await SharedPreferences.getInstance();
      final history = prefs.getStringList('quiz_history') ?? [];
      history.add('Result: $_currentScore/${staticQuestions.length}');
      await prefs.setStringList('quiz_history', history);

      emit(QuizFinished(_currentScore, staticQuestions.length));
    }
  }
}
