import 'dart:math';

class QuestionGenerator {
  QuestionGenerator({Random? random}) : _random = random ?? Random();

  final Random _random;

  List<String> get _operators => ['+', '-', '*', '/'];

  int generateFirstOperand() {
    return _random.nextInt(100) + 1;
  }

  int generateSecondOperand() {
    return _random.nextInt(100) + 1;
  }

  String generateOperator() {
    var nextInt = _random.nextInt(_operators.length);
    return _operators[nextInt];
  }
}
