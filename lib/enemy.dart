import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'character.dart';

// Enum to represent different types of enemies
enum EnemyType { angryPig, bat, rino }

// Class to store data for different enemies
class EnemyData {
  final String imageName;
  final Vector2 srcSize;
  final int to;
  EnemyData({required this.imageName, required this.srcSize, required this.to});
}

// Enemy class extending the Character class
class Enemy extends Character {
  late int textureWidth;
  late int textureHeight;
  double speed = 200;
  static final Map<EnemyType, EnemyData> _enemyDetails = {
    EnemyType.angryPig: EnemyData(
        imageName: 'Walk (36x30).png', srcSize: Vector2(36, 30), to: 15),
    EnemyType.bat: EnemyData(
        imageName: 'Flying (46x30).png', srcSize: Vector2(46, 30), to: 6),
    EnemyType.rino: EnemyData(
        imageName: 'Run (52x34).png', srcSize: Vector2(52, 34), to: 5),
  };

  late double characterX;
  late double characterY;
  late double characterHeight;
  late double characterWidth;
  late double setSize;

  Enemy({
    required EnemyType type,
    required Vector2 initialSize,
    required Vector2 initialPosition,
  }) : super(
            size: initialSize,
            position: initialPosition,
            spriteSheet: SpriteSheet(
              image: Flame.images.fromCache(_enemyDetails[type]!.imageName),
              srcSize: _enemyDetails[type]!.srcSize,
            ),
            animationData: AnimationData(
              row: 0,
              from: 0,
              to: _enemyDetails[type]!.to,
              stepTime: 0.1,
            ),
  ){
    textureWidth =  _enemyDetails[type]!.srcSize.x.toInt();
    textureHeight =  _enemyDetails[type]!.srcSize.y.toInt();

  }

  void resize(Vector2 size, double groundHeight, int numberOfTilesAlongWidth) {
    double scaleFactor = (size.x / numberOfTilesAlongWidth) / textureWidth;
    characterHeight = textureHeight * scaleFactor;
    characterWidth = textureWidth * scaleFactor;
    characterX = size.x + characterWidth;
    characterY = size.y - groundHeight - characterHeight - 10;
    this.size = Vector2(characterWidth, characterHeight);
    this.position = Vector2(characterX, characterY);
    setSize = size.x;
  }

  void updatePositionOfX(double dt) {
    characterX -= speed * dt;
    if (characterX < (-characterWidth)) {
      characterX = setSize + characterWidth;
    }
    this.position = Vector2(characterX, characterY);
  }
}
