const List<Question> staticQuestions = [
  Question(
    text: 'What programming language is used in Flutter?',
    options: ['Java', 'Dart', 'Swift', 'C++'],
    correctAnswerIndex: 1,
  ),
  Question(
    text:
        'Which method is called only once during the entire lifecycle of the State widget?',
    options: ['build()', 'didUpdateWidget()', 'initState()', 'setState()'],
    correctAnswerIndex: 2, // initState()
  ),
  Question(
    text: 'Is Flutter an open source framework?',
    options: ['Yes', 'No', 'Only for Android'],
    correctAnswerIndex: 0,
  ),
];

class Question {
  final String text;
  final List<String> options;
  final int correctAnswerIndex;

  const Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });
}
