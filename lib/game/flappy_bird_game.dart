import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird_game/components/background.dart';
import 'package:flappy_bird_game/components/bird.dart';
import 'package:flappy_bird_game/components/ground.dart';
import 'package:flappy_bird_game/components/pipe_group.dart';
import 'package:flappy_bird_game/game/configuration.dart';
import 'package:flutter/painting.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBirdGame();

  late Bird bird;
  Timer interval = Timer(Config.pipeInterval, repeat: true);
  bool isHit = false;
  late TextComponent score;
  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      score = buildScore(),
      buildScoreTitle()
    ]);
    interval.onTick = () => add(PipeGroup());
  }

  TextComponent buildScoreTitle() {
    return TextComponent(
        position: Vector2(size.x / 2, size.y - Config.groundHeight / 2 - 20),
        anchor: Anchor.center,
        text: "Pont",
        textRenderer: TextPaint(
          style: const TextStyle(
              color: Color(0xFF4C0519),
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ));
  }

  TextComponent buildScore() {
    return TextComponent(
        position: Vector2(size.x / 2, size.y - Config.groundHeight / 2 + 10),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
              color: Color(0xFF4C0519),
              fontSize: 32,
              fontWeight: FontWeight.w700),
        ));
  }

  @override
  void onTap() {
    bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = '${bird.score}';
  }
}
