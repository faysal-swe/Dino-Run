import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Character extends SpriteAnimationComponent {
  double speedY = 0.0;
  double yMax = 0.0;
  final double gravity = 1000;

  Character({
    required Vector2 size,
    required Vector2 position,
    required SpriteSheet spriteSheet,
    required AnimationData animationData,
  }) {
    this.animation = spriteSheet.createAnimation(
      row: animationData.row,
      from: animationData.from,
      to: animationData.to,
      stepTime: animationData.stepTime,
    );
    this.size = size;
    this.position = position;
  }

  void applyGravity(double dt) {
    speedY += gravity * dt;
    position.y += speedY * dt;
    if (isOnGround()) {
      position.y = yMax;
      speedY = 0.0;
    }
  }

  bool isOnGround() {
    return position.y >= yMax;
  }

  void jump(double jumpSpeed) {
    if (isOnGround()) {
      speedY = jumpSpeed;
    }
  }
}

class AnimationData {
  final int row;
  final int from;
  final int to;
  final double stepTime;

  AnimationData({
    required this.row,
    required this.from,
    required this.to,
    required this.stepTime,
  });
}
