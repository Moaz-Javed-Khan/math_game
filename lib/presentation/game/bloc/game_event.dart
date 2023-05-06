part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class QuestionGenerated extends GameEvent {
  const QuestionGenerated();

  @override
  List<Object?> get props => [];
}

class AnswerSubmitted extends GameEvent {
  const AnswerSubmitted({required this.operator});

  final String operator;

  @override
  List<Object?> get props => [operator];
}
