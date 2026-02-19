import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';

class TrainWidget extends ConsumerWidget {
  final double tileSize;

  const TrainWidget({super.key, required this.tileSize});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);
    final (row, col) = gameState.trainPosition;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      top: row * tileSize,
      left: col * tileSize,
      width: tileSize,
      height: tileSize,
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Image.asset(
          'assets/images/bear_train.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
