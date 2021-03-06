import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/time.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as Anim;

const groudHeight = 15;
const ratioOfDinoSize = 10;
const GRAVITY = 1000.0;

class Dino extends AnimationComponent {
  Anim.Animation _runanimation;
  Anim.Animation _hitanimation;
  double yinitial = 0.0;
  double speedY = 0.0;
  Timer _timer;
  bool _isHit = false;

  Dino() : super.empty() {
    final spriteImage = SpriteSheet(
      imageName: 'DinoSprites - vita.png',
      textureWidth: 24,
      textureHeight: 24,
      columns: 24,
      rows: 1,
    );
    _hitanimation = spriteImage.createAnimation(
      0,
      from: 14,
      to: 16,
      stepTime: 0.1,
    );
    _runanimation = spriteImage.createAnimation(
      0,
      from: 4,
      to: 10,
      stepTime: 0.1,
    );

    this.anchor = Anchor.center;

    this.animation = _runanimation;
    _timer = Timer(2, callback: () {
      run();
    });
  }

  @override
  void update(double t) {
    super.update(t);
    // Max Height
    //v = u + at;
    this.speedY += GRAVITY * t;
    // d=s*t
    this.y += this.speedY * t;
    if (isOnGround()) {
      this.y = this.yinitial;
      this.speedY = 0.0;
    }
    _timer.update(t);
  }

  @override
  void resize(Size size) {
    super.resize(size);
    this.height = this.width = size.width / ratioOfDinoSize;
    this.x = this.width;
    this.y = size.height - (this.height / 2) - groudHeight + 10;
    this.yinitial = this.y;
  }

  bool isOnGround() {
    return (this.y >= yinitial);
  }

  void run() {
    _isHit = false;
    this.animation = _runanimation;
  }

  void hit() {
    if (!_isHit) {
      this.animation = _hitanimation;
      _timer.start();
      _isHit = true;
    }
  }

  void jump() {
    if (isOnGround()) this.speedY = -450;
  }
}
