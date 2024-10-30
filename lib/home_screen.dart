import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'base_game.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GameWidget(
          game: BaseGame(),
          overlayBuilderMap: {
            'PauseMenu': (context, game) {
              return Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: Text('A pause menu', style: TextStyle(color: Colors.white, fontSize: 24)),
                ),
              );
            },
          },
        ),
      ),
    );
  }
}