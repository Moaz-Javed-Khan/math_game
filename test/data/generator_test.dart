import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathgame/data/generator.dart';
import 'package:mocktail/mocktail.dart';

class MockRandom extends Mock implements Random {}

void main() {
  final Random random = MockRandom();
  final generator = QuestionGenerator(random: random);

  group("Testing random generator", () {
    when(() => random.nextInt(any())).thenReturn(3);

    test("Test 1st operand generator", () {
      int result = generator.generateFirstOperand();

      expect(result, 4);
    });
    test("Test 2nd operand generator", () {
      int result = generator.generateSecondOperand();

      expect(result, 4);
    });

    test('Test operator generator', () {
      String operator = generator.generateOperator();
      expect(operator, '/');
    });
  });
}
