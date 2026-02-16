import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_state.dart';
import '../providers/game_provider.dart';

class GameControls extends ConsumerWidget {
  const GameControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);
    final isPlaying = gameState.status == GameStatus.playing;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: isPlaying ? null : () => ref.read(gameProvider.notifier).clearCommands(),
            icon: const Icon(Icons.delete),
            label: const Text("Clear"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[100],
              foregroundColor: Colors.red,
            ),
          ),
          ElevatedButton.icon(
            onPressed: isPlaying ? null : () => ref.read(gameProvider.notifier).resetGame(),
            icon: const Icon(Icons.replay),
            label: const Text("Reset"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[100],
              foregroundColor: Colors.orange,
            ),
          ),
          ElevatedButton.icon(
            onPressed: isPlaying
                ? null
                : () {
                    ref.read(gameProvider.notifier).playSequence();
                  },
            icon: const Icon(Icons.play_arrow),
            label: const Text("Play"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
