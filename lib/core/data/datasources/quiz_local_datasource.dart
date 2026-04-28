import 'package:shared_preferences/shared_preferences.dart';

abstract class QuizLocalDataSource {
  Future<List<String>> getHistory();
  Future<void> cacheResult(String result);
}

class QuizLocalDataSourceImpl implements QuizLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String historyKey = 'quiz_history';

  QuizLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<String>> getHistory() async {
    return sharedPreferences.getStringList(historyKey) ?? [];
  }

  @override
  Future<void> cacheResult(String result) async {
    final history = await getHistory();
    history.add(result);
    await sharedPreferences.setStringList(historyKey, history);
  }
}