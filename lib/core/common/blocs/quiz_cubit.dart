import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/question.dart';
import '../../domain/usecases/get_questions.dart';
import '../../domain/usecases/get_quiz_history.dart';
import '../../domain/usecases/save_quiz_result.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final GetQuizHistory _getQuizHistory;
  final SaveQuizResult _saveQuizResult;
  final GetQuestions _getQuestions;

  QuizCubit({
    required GetQuizHistory getQuizHistory,
    required SaveQuizResult saveQuizResult,
    required GetQuestions getQuestions,
  }) : _getQuizHistory = getQuizHistory,
        _saveQuizResult = saveQuizResult,
        _getQuestions = getQuestions, super(QuizInitial());

  int _currentScore = 0;
  int _currentIndex = 0;
  late List<Question> _questions;

  Future<void> loadHistory() async {
    final history = await _getQuizHistory();
    if (history.isNotEmpty) {
      emit(QuizHistoryLoaded(history));
    } else {
      emit(QuizNoHistory());
    }
  }

  void startQuiz() {
    _questions = _getQuestions();
    _currentIndex = 0;
    _currentScore = 0;
    emit(QuizInProgress(_currentIndex, 0, _questions));
  }

  Future<void> submitAnswer(int selectedIndex) async {
    if (selectedIndex == _questions[_currentIndex].correctAnswerIndex) {
      _currentScore++;
    }

    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      emit(QuizInProgress(_currentIndex, _currentScore, _questions));
    } else {
      final resultString = 'Result: $_currentScore/${_questions.length}';
      await _saveQuizResult(resultString);
      emit(QuizFinished(_currentScore, _questions.length));
    }
  }
}
