import 'package:flame/components.dart';
import 'character.dart';

class Dino extends Character {
  Dino({
    required super.size,
    required super.position,
    required super.spriteSheet,
  }) : super(
    animationData: AnimationData(
      row: 0,
      from: 4,
      to: 10,
      stepTime: 0.1,
    ),
  );

  void resize(Vector2 size, double groundHeight, int numberOfTilesAlongWidth) {
    final double characterHeight = size.x / numberOfTilesAlongWidth;
    final double characterWidth = characterHeight;
    final double characterX = characterWidth;
    final double characterY = size.y - groundHeight - characterHeight - 10;
    this.size = Vector2(characterWidth, characterHeight);
    this.position = Vector2(characterX, characterY);
    this.yMax = characterY;
  }
}
