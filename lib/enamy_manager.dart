import 'dart:math';

import 'package:dino_run/enemy.dart';
import 'package:flame/components.dart';
import 'base_game.dart';

class EnemyManager extends Component with HasGameRef<BaseGame> {
  late Random _random;
  late Timer _timer;
  late  Enemy enemy;

  EnemyManager() {
    _random = Random();

    _timer = Timer(4, repeat: true, onTick: () {
      spawnRandomEnemy();
    });
  }

  void spawnRandomEnemy() {
    final randomNumber = _random.nextInt(EnemyType.values.length);
    final randomEnemyType = EnemyType.values.elementAt(randomNumber);
    final newEnemy = Enemy(
        type: randomEnemyType,
        initialSize: Vector2.zero(),
        initialPosition: Vector2.zero());
    add(newEnemy);
    print('Added enemy: $newEnemy at position: ${newEnemy.position}');
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    _timer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }
}
