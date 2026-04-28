import '../repositories/quiz/quiz_repository.dart';

class SaveQuizResult {
  final QuizRepository repository;

  SaveQuizResult(this.repository);

  Future<void> call(String result) => repository.saveQuizResult(result);
}
