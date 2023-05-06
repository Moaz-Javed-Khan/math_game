import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mathgame/data/generator.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState()) {
    on<QuestionGenerated>((_, emit) => _generateQuestion(emit));
    on<AnswerSubmitted>(_checkAnswer);
  }

  void _generateQuestion(Emitter<GameState> emit) {
    final gen = QuestionGenerator();
    final num result;
    var questionString = '';
    final firstOperand = gen.generateFirstOperand();
    final secondOperand = gen.generateSecondOperand();
    final operator = gen.generateOperator();

    switch (operator) {
      case "+":
        result = firstOperand + secondOperand;
        questionString = "$firstOperand ? $secondOperand = $result";
        break;
      case "-":
        result = firstOperand - secondOperand;
        questionString = "$firstOperand ? $secondOperand = $result";
        break;
      case "*":
        result = firstOperand * secondOperand;
        questionString = "$firstOperand ? $secondOperand = $result";
        break;
      case "/":
        result = firstOperand / secondOperand;
        questionString = "$firstOperand ? $secondOperand = $result";
        break;
      default:
        questionString = "Invalid.";
    }

    emit(
      state.copyWith(
        currentQuestion: questionString,
        currentAnswer: operator,
      ),
    );
  }

  void _checkAnswer(AnswerSubmitted event, Emitter<GameState> emit) {
    if (state.currentAnswer == event.operator) {
      emit(
        state.copyWith(
          score: state.score + 1,
          isAnswerCorrect: true,
        ),
      );
      _generateQuestion(emit);
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text("Correct Answer"),
      // ));
    } else {
      if (state.health < 1) return;
      emit(
        state.copyWith(
          health: state.health - 1,
          isAnswerCorrect: false,
        ),
      );
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text("Wrong answer! ${state.health} chances left"),
      // ));
    }
  }
}
