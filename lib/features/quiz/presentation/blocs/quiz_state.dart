part of 'quiz_cubit.dart';

abstract class QuizState {
  const QuizState();
}

class QuizInitial extends QuizState {}

class QuizHistoryLoaded extends QuizState {
  const QuizHistoryLoaded(this.history);

  final List<String> history;
}

class QuizNoHistory extends QuizState {}

class QuizInProgress extends QuizState {
  const QuizInProgress(this.currentQuestionIndex, this.currentScore);

  final int currentQuestionIndex;
  final int currentScore;
}

class QuizFinished extends QuizState {
  const QuizFinished(this.totalScore, this.totalQuestions);

  final int totalScore;
  final int totalQuestions;
}

class QuizError extends QuizState {
  const QuizError(this.message);

  final String message;
}
