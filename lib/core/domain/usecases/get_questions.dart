import '../entities/question.dart';
import '../repositories/quiz/quiz_repository.dart';

class GetQuestions {
  final QuizRepository repository;

  GetQuestions(this.repository);

  List<Question> call() => repository.getQuestions();
}
