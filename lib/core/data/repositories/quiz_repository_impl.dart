import '../../domain/entities/question.dart';
import '../../domain/repositories/quiz/quiz_repository.dart';
import '../datasources/quiz_local_datasource.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizLocalDataSource localDataSource;

  QuizRepositoryImpl(this.localDataSource);

  @override
  List<Question> getQuestions() {
    return const [
      Question(
        text: 'What programming language is used in Flutter?',
        options: ['Java', 'Dart', 'Swift', 'C++'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Which method is called only once during the entire lifecycle?',
        options: ['build()', 'didUpdateWidget()', 'initState()', 'setState()'],
        correctAnswerIndex: 2,
      ),
      Question(
        text: 'Is Flutter an open source framework?',
        options: ['Yes', 'No', 'Only for Android'],
        correctAnswerIndex: 0,
      ),
    ];
  }

  @override
  Future<List<String>> getQuizHistory() => localDataSource.getHistory();

  @override
  Future<void> saveQuizResult(String result) => localDataSource.cacheResult(result);
}