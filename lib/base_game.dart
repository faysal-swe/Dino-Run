import 'dart:developer';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class BaseGame extends FlameGame with TapDetector{
  late double _dinoHeight;
  late double _dinoWidth;
  late double _dinoX;
  late double _dinoY;
  final _groundHeight = 32;
  final int _numberOfTilesAlongWidth = 10;
  double _speedY = 0.0;
  double _yMax = 0.0;
  final double gravity = 1000;

  final dino = SpriteAnimationComponent();
  ValueNotifier<String> uiNotifier = ValueNotifier<String>('');

  @override
  Future<void> onLoad() async {
    super.onLoad();
    uiNotifier.addListener(() { addDino(); });
    await addParallax();
    await addDino();// Initialize your game

  }

  @override
  void update(double dt) async{
    super.update(dt);
    _speedY += gravity * dt;
    _dinoY += _speedY *dt;
    log(_dinoY.toString());

    if(isOnGround()){
      _dinoY =  _yMax;
      _speedY = 0.0;
    }
    dino.position = Vector2(_dinoX, _dinoY);
    // Game logic here
  }

  bool isOnGround(){
    return (_dinoY >= _yMax);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Rendering logic here
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    log('New canvas size: $size');
    _dinoHeight = _dinoWidth = size.x / _numberOfTilesAlongWidth;
    _dinoX = _dinoWidth;
    _dinoY = size.y - _groundHeight - _dinoHeight - 10;
    _yMax = _dinoY;
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    log('Screen tapped');
    jump();
  }

  void jump(){
    _speedY = -600; // y is negative in flame engine
  }

  Future<void> addDino() async {
    final spriteSheet = SpriteSheet(
      image: await images.load('DinoSprites - tard.png'),
      srcSize: Vector2(24, 24),
    );
    final dinoRunAnimation = spriteSheet.createAnimation(
      row: 0,
      from: 4,
      to: 10,
      stepTime: 0.1,
    );
    final dinoHitAnimation = spriteSheet.createAnimation(
      row: 0,
      from: 14,
      to: 16,
      stepTime: 0.1,
    );
    dino.animation = dinoRunAnimation;
    dino.size = Vector2(_dinoWidth, _dinoHeight);
    dino.position = Vector2(_dinoX, _dinoY);
    add(dino);
  }
  Future<void> addParallax()async{
    final parallaxComponent = await loadParallaxComponent(
      [
        ParallaxImageData('parallax/plx-1.png'),
        ParallaxImageData('parallax/plx-2.png'),
        ParallaxImageData('parallax/plx-3.png'),
        ParallaxImageData('parallax/plx-4.png'),
        ParallaxImageData('parallax/plx-5.png'),
        ParallaxImageData('parallax/plx-6.png'),
      ],
      baseVelocity: Vector2(100, 0), // Controls the scrolling speed
      velocityMultiplierDelta:
      Vector2(1.1, 1.0), // Layers move at different speeds
    );
    add(parallaxComponent);
  }
}
