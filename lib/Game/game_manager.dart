import 'dart:math';
import 'dart:ui';

import 'package:dino_world/Game/Enemies/enemies.dart';
import 'package:dino_world/Game/parallax_backgroud.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';

class EnemyManager extends Component with HasGameRef<DinoGame> {
  Timer _timer;
  Random _random;
  int spawnLevel;

  EnemyManager() {
    _random = Random();
    spawnLevel = 0;
    _timer = Timer(4, repeat: true, callback: () {
      spawnEnemy();
    });
  }

  void spawnEnemy() {
    final randomEnemyNo = _random.nextInt(EnemyType.values.length);
    final randomEnemyType = EnemyType.values.elementAt(randomEnemyNo);
    final enemy = new Enemy(randomEnemyType);
    gameRef.addLater(enemy);
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void render(Canvas c) {}

  @override
  void update(double t) {
    _timer.update(t);
    var newSpawnLevel = (gameRef.score ~/ 500);
    if (spawnLevel < newSpawnLevel) {
      spawnLevel = newSpawnLevel;
      var newTime = (4 / (1 + 0.1 * spawnLevel));
      _timer.stop();
      _timer = Timer(newTime, repeat: true, callback: () {
        spawnEnemy();
      });
      _timer.start();
    }
  }
}
