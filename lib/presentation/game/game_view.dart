import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mathgame/presentation/game/bloc/game_bloc.dart';
import 'package:mathgame/presentation/home_page.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameBloc()..add(const QuestionGenerated()),
      child: const GameView(),
    );
  }
}

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GameBloc, GameState>(
        listenWhen: (previous, current) =>
            previous.isAnswerCorrect != current.isAnswerCorrect ||
            previous.health != current.health,
        listener: (context, state) {
          if (state.isAnswerCorrect) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Correct Answer"),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Wrong answer! ${state.health} chance(s) left"),
              duration: const Duration(seconds: 1),
            ));
            if (state.health == 0) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) {
                    return WillPopScope(
                      onWillPop: () async => false,
                      child: AlertDialog(
                        title: const Text("Game Over!"),
                        actions: [
                          TextButton(
                            child: const Text("Main Menu"),
                            onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyHomePage(),
                              ),
                            ),
                          ),
                          TextButton(
                            child: const Text("Restart"),
                            onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GamePage(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 52.0,
              left: 16.0,
              right: 16.0,
              top: 20.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Score: ${state.score}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          "Life: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: List.generate(state.health, (index) {
                            return const Icon(
                              Icons.favorite,
                              size: 20.0,
                              color: Colors.red,
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      state.currentQuestion ?? '',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Choose Correct Answer",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    GestureDetector(
                      onTap: () => context
                          .read<GameBloc>()
                          .add(const AnswerSubmitted(operator: "+")),
                      child: const CircleAvatar(
                        radius: 26.0,
                        backgroundColor: Colors.lime,
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context
                          .read<GameBloc>()
                          .add(const AnswerSubmitted(operator: "-")),
                      child: const CircleAvatar(
                        radius: 26.0,
                        backgroundColor: Colors.lime,
                        child: Icon(
                          Icons.remove,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context
                          .read<GameBloc>()
                          .add(const AnswerSubmitted(operator: "*")),
                      child: const CircleAvatar(
                        radius: 26.0,
                        backgroundColor: Colors.lime,
                        child: Text(
                          "X",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context
                          .read<GameBloc>()
                          .add(const AnswerSubmitted(operator: "/")),
                      child: const CircleAvatar(
                        radius: 26.0,
                        backgroundColor: Colors.lime,
                        child: Text(
                          "/",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
