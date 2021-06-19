import 'package:dino_world/Game/parallax_backgroud.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.fullScreen();
  await Flame.util.setLandscape();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DinoGame dinoGame;
  @override
  void initState() {
    super.initState();
    dinoGame = DinoGame();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: dinoGame.widget,
      ),
    );
  }
}
