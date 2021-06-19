import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';

class Dino extends AnimationComponent {
  Dino() : super.empty() {
    final spriteImage = SpriteSheet(
      imageName: 'DinoSprites - vita.png',
      textureWidth: 24,
      textureHeight: 24,
      columns: 24,
      rows: 1,
    );
    final idelAnimation = spriteImage.createAnimation(
      0,
      from: 0,
      to: 3,
      stepTime: 0.1,
    );
    final runAnimation = spriteImage.createAnimation(
      0,
      from: 4,
      to: 10,
      stepTime: 0.1,
    );
    this.animation = runAnimation;
    this.height = 80;
    this.width = 80;
    this.x = 100;
    this.y = 300;
  }
}
