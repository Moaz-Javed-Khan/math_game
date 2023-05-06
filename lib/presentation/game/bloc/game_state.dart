part of 'game_bloc.dart';

class GameState extends Equatable {
  final int health;
  final int score;
  final String? currentQuestion;
  final String? currentAnswer;
  final bool isAnswerCorrect;

  const GameState({
    this.health = 3,
    this.score = 0,
    this.currentQuestion,
    this.currentAnswer,
    this.isAnswerCorrect = false,
  });

  GameState copyWith({
    int? health,
    int? score,
    String? currentQuestion,
    String? currentAnswer,
    bool? isAnswerCorrect,
  }) {
    return GameState(
      health: health ?? this.health,
      score: score ?? this.score,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      currentAnswer: currentAnswer ?? this.currentAnswer,
      isAnswerCorrect: isAnswerCorrect ?? this.isAnswerCorrect,
    );
  }

  @override
  List<Object?> get props => [
        health,
        score,
        currentQuestion,
        currentAnswer,
        isAnswerCorrect,
      ];
}
