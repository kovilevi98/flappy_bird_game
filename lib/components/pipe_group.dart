import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird_game/components/pipe.dart';
import 'package:flappy_bird_game/components/pipe_end.dart';
import 'package:flappy_bird_game/game/assets.dart';
import 'package:flappy_bird_game/game/configuration.dart';
import 'package:flappy_bird_game/game/flappy_bird_game.dart';
import 'package:flappy_bird_game/game/pipe_position.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();

  final _random = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    final spacing = 150 + _random.nextDouble() * (heightMinusGround / 4);
    final centerY =
        spacing + _random.nextDouble() * (heightMinusGround - spacing);
    final pipeEnding = await Flame.images.load(Assets.pipeEnd);

    addAll([
      Pipe(pipePosition: PipePosition.top, height: centerY - spacing / 2),
      if (centerY - spacing / 2 > 40)
        PipeEnd(
            pipePosition: Vector2(0, -50),
            height: centerY - spacing / 2,
            pipeType: PipePosition.top),
      Pipe(
          pipePosition: PipePosition.bottom,
          height: heightMinusGround - (centerY + spacing / 2)),
      if (heightMinusGround - (centerY + spacing / 2) > 40)
        PipeEnd(
            pipePosition: Vector2(0, -50),
            height: heightMinusGround - (centerY + spacing / 2),
            pipeType: PipePosition.bottom),
    ]);
  }

  void updateScore() {
    gameRef.bird.score += 1;
    FlameAudio.play(Assets.point);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;

    if (position.x < -10) {
      removeFromParent();
      updateScore();
    }

    if (gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }
  }
}
