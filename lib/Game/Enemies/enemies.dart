import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';

const groudHeight = 15;
const ratioOfDinoSize = 10;

enum EnemyType {
  AngryPig,
  Bat,
  Rino,
}

class EnemyData {
  final String imageName;
  final int textureWidth;
  final int textureHeight;
  final int columns;
  final int row;

  const EnemyData({
    this.imageName,
    this.textureHeight,
    this.textureWidth,
    this.columns,
    this.row,
  });
}

class Enemy extends AnimationComponent {
  Animation _runAnimation;
  double speed = 200.0;
  double xinitial = 0.0;
  int textureWidth;
  int textureHeight;
  EnemyType currentEnemyType;

  static const Map<EnemyType, EnemyData> enemies = {
    EnemyType.AngryPig: EnemyData(
      imageName: 'AngryPig/Run (36x30).png',
      textureWidth: 36,
      textureHeight: 30,
      columns: 12,
      row: 1,
    ),
    EnemyType.Bat: EnemyData(
      imageName: 'Bat/Flying (46x30).png',
      textureWidth: 46,
      textureHeight: 30,
      columns: 7,
      row: 1,
    ),
    EnemyType.Rino: EnemyData(
      imageName: 'Rino/Run (52x34).png',
      textureWidth: 52,
      textureHeight: 34,
      columns: 6,
      row: 1,
    ),
  };

  Enemy(EnemyType enemyType) : super.empty() {
    this.currentEnemyType = enemyType;
    final enemyData = enemies[enemyType];
    final spriteImage = SpriteSheet(
      imageName: enemyData.imageName,
      textureWidth: enemyData.textureWidth,
      textureHeight: enemyData.textureHeight,
      columns: enemyData.columns,
      rows: enemyData.row,
    );

    _runAnimation = spriteImage.createAnimation(
      0,
      from: 0,
      to: enemyData.columns - 1,
      stepTime: 0.05,
      loop: true,
    );

    this.textureHeight = enemyData.textureHeight;
    this.textureWidth = enemyData.textureWidth;
    this.anchor = Anchor.center;
    this.animation = _runAnimation;
  }

  @override
  void resize(Size size) {
    super.resize(size);
    double scaleFactor = (size.width / ratioOfDinoSize) / this.textureWidth;
    this.height = this.textureHeight * scaleFactor;
    this.width = this.textureWidth * scaleFactor;
    if (this.currentEnemyType == EnemyType.Bat) {
      this.y = size.height - (this.height / 2) - groudHeight;
    } else {
      this.y = size.height - (this.height / 2) - groudHeight;
    }
    this.x = size.width + this.width;
    this.xinitial = this.x;
  }

  @override
  void update(double t) {
    super.update(t);
    this.x -= speed * t;
  }

  bool destroy() {
    return (this.x < -this.textureWidth);
  }

  @override
  void onDestroy() {
    super.onDestroy();
    destroy();
  }
}
