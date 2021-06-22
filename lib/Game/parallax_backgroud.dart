import 'package:dino_world/Game/Enemies/enemies.dart';
import 'package:dino_world/Game/dino.dart';
import 'package:dino_world/Game/game_manager.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/cupertino.dart';

class DinoGame extends BaseGame with TapDetector {
  Dino _dino = Dino();
  EnemyManager _enemyManager;
  ParallaxComponent parallaxComponent;
  int score = 0;
  TextComponent _textComponent;

  DinoGame() {
    parallaxComponent = ParallaxComponent(
      [
        ParallaxImage('parallax/far-buildings.png'),
        ParallaxImage('parallax/back-buildings.png'),
        ParallaxImage('parallax/foreground.png'),
      ],
      baseSpeed: Offset(70, 0),
      layerDelta: Offset(10, 0),
    );
    add(parallaxComponent);
    add(_dino);
    _enemyManager = EnemyManager();
    add(_enemyManager);
    //add(_enemies);
    _textComponent = TextComponent('Score : ${score.toString()}',
        config: TextConfig(color: Color(0xFFFFFFFF), fontSize: 24));

    add(_textComponent);
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);
    _dino.jump();
  }

  @override
  void resize(Size size) {
    super.resize(size);
    _textComponent.setByPosition(
        Position((size.width / 2) - (_textComponent.width / 2), 0));
  }

  @override
  void update(double t) {
    super.update(t);
    score += (60 * t).toInt();
    _textComponent.text = 'Score : ${score.toString()}';

    components.whereType<Enemy>().forEach((enemy) {
      if (_dino.distance(enemy) < 20) {
        _dino.hit();
      }
    });
  }
}
