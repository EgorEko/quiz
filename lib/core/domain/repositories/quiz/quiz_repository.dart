import '../../entities/question.dart';

abstract class QuizRepository {
  Future<List<String>> getQuizHistory();
  Future<void> saveQuizResult(String result);
  List<Question> getQuestions();
}