import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/command.dart';
import '../providers/game_provider.dart';

class TrainWidget extends ConsumerWidget {
  final double tileSize;

  const TrainWidget({super.key, required this.tileSize});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);
    final (row, col) = gameState.trainPosition;
    final direction = gameState.trainDirection;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      top: row * tileSize,
      left: col * tileSize,
      width: tileSize,
      height: tileSize,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        tween: Tween(end: _getRotation(direction)),
        builder: (context, angle, child) {
          return Transform.rotate(
            angle: angle,
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(4),
          child: Image.asset(
            'assets/images/bear_train.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  double _getRotation(Direction direction) {
    switch (direction) {
      case Direction.east:
        return 0;
      case Direction.south:
        return 1.5708; // 90 degrees in radians
      case Direction.west:
        return 3.14159; // 180 degrees
      case Direction.north:
        return 4.71239; // 270 degrees
    }
  }
}
