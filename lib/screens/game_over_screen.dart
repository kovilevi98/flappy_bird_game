import 'package:flappy_bird_game/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final FlappyBirdGame game;

  const GameOverScreen({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.black38,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: const Color(0xFFEBE791),
                    border:
                        Border.all(color: const Color(0xFF292929), width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "Játék vége",
                      style: TextStyle(
                          color: Color(0xFF4C0519),
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "Pont",
                      style: TextStyle(
                          color: Color(0xFF4C0519),
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "${game.bird.score}",
                      style: const TextStyle(
                          color: Color(0xFF4C0519),
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 48),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32.0),
                              child: ElevatedButton(
                                onPressed: onRestart,
                                style: ButtonStyle(
                                    //shape: OutlinedBorder,
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xFF3D832C)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            side: const BorderSide(
                                                color: Colors.transparent)))),
                                child: const Text('Újrajátszom',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  void onRestart() {
    game.bird.reset();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}
