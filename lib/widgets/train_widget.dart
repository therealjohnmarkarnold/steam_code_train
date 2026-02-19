import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../providers/train_color_provider.dart';

class TrainWidget extends ConsumerWidget {
  final double tileSize;

  const TrainWidget({super.key, required this.tileSize});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);
    final (row, col) = gameState.trainPosition;
    final trainColor = ref.watch(trainColorProvider);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      top: row * tileSize,
      left: col * tileSize,
      width: tileSize,
      height: tileSize,
      child: Container(
        padding: const EdgeInsets.all(4),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            trainColor,
            BlendMode.modulate,
          ),
          child: Image.asset(
            'assets/images/bear_train.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
