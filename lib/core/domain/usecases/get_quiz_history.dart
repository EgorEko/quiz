import '../repositories/quiz/quiz_repository.dart';

class GetQuizHistory {
  final QuizRepository repository;

  GetQuizHistory(this.repository);

  Future<List<String>> call() => repository.getQuizHistory();
}
