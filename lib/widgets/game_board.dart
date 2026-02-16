import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import 'grid_tile_widget.dart';
import 'train_widget.dart';

class GameBoard extends ConsumerWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);
    final level = gameState.level;

    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tileSize = constraints.maxWidth / level.cols;

          return Stack(
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: level.rows * level.cols,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: level.cols,
                ),
                itemBuilder: (context, index) {
                  final row = index ~/ level.cols;
                  final col = index % level.cols;
                  return GridTileWidget(
                    type: level.grid[row][col],
                    row: row,
                    col: col,
                  );
                },
              ),
              TrainWidget(tileSize: tileSize),
            ],
          );
        },
      ),
    );
  }
}
