import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird_game/game/assets.dart';
import 'package:flappy_bird_game/game/configuration.dart';
import 'package:flappy_bird_game/game/flappy_bird_game.dart';
import 'package:flappy_bird_game/game/pipe_position.dart';

class PipeEnd extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  PipeEnd(
      {required this.pipePosition,
      required this.height,
      required this.pipeType});

  @override
  final double height;
  final PipePosition pipeType;
  final Vector2 pipePosition;

  @override
  Future<void> onLoad() async {
    final pipeEnd = await Flame.images.load(Assets.pipeEnd);
    size = Vector2(60, 40);
    switch (pipeType) {
      case PipePosition.top:
        position.y = height - 40;
        sprite = Sprite(pipeEnd);
        break;
      case PipePosition.bottom:
        position.y = gameRef.size.y - height - Config.groundHeight;
        sprite = Sprite(pipeEnd);
        break;
    }

    add(RectangleHitbox());
  }
}
