import 'package:dino_world/Game/dino.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';

class DinoGame extends BaseGame with TapDetector {
  Dino _dino = Dino();
  ParallaxComponent parallaxComponent;

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
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);
    _dino.jump();
  }
}
