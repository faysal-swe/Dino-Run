import 'dart:developer';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'dino.dart';
import 'enemy.dart';

class BaseGame extends FlameGame with TapDetector {
  final double _groundHeight = 32;
  final int _numberOfTilesAlongWidth = 10;
  Dino? dino;
  Enemy? enemy;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await preloadImages();
    await addParallax();
    await initializeDino();
    await initializeEnemy();
    onGameResize(size);
  }

  Future<void> preloadImages() async {
    await images.loadAll([
      'Walk (36x30).png',
      'Flying (46x30).png',
      'Run (52x34).png',
      'DinoSprites - tard.png',
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    dino?.applyGravity(dt);
    enemy?.updatePositionOfX(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    log('New canvas size: $size');
    dino?.resize(size, _groundHeight, _numberOfTilesAlongWidth);
    enemy?.resize(size, _groundHeight, _numberOfTilesAlongWidth);
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    log('Screen tapped');
    dino?.jump(-600); // y is negative in flame engine
  }

  Future<void> initializeDino() async {
    final spriteSheet = SpriteSheet(
      image: await images.load('DinoSprites - tard.png'),
      srcSize: Vector2(24, 24),
    );
    dino = Dino(
      size: Vector2.zero(), // Temporary size until onGameResize is called
      position:
          Vector2.zero(), // Temporary position until onGameResize is called
      spriteSheet: spriteSheet,
    );
    add(dino!);
  }

  Future<void> initializeEnemy() async {
    enemy = Enemy(
      type: EnemyType.angryPig,
      initialSize:
          Vector2.zero(), // Temporary size until onGameResize is called
      initialPosition:
          Vector2.zero(), // Temporary position until onGameResize is called
    );

    add(enemy!);
  }

  Future<void> addParallax() async {
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
