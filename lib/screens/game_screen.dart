import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/game_board.dart';
import '../widgets/command_palette.dart';
import '../widgets/process_flow.dart';
import '../widgets/game_controls.dart';
import '../providers/game_provider.dart';
import '../models/game_state.dart';


class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(gameProvider, (previous, next) {
      if (next.status == GameStatus.levelComplete && previous?.status != GameStatus.levelComplete) {
        _showLevelCompleteDialog(context, ref);
      } else if (next.status == GameStatus.crashed && previous?.status != GameStatus.crashed) {
        _showCrashDialog(context, ref);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Steam Code Train'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,

      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isLandscape = constraints.maxWidth > constraints.maxHeight;

            if (isLandscape) {
              return Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: GameBoard()),
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: CommandPalette(),
                        ),
                        const Divider(height: 1),
                        const SizedBox(
                          height: 120,
                          child: ProcessFlow(),
                        ),
                        const GameControls(),
                      ],
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: GameBoard()),
                  ),
                ),
                const Divider(height: 1),
                const Expanded(
                  flex: 1,
                  child: CommandPalette(),
                ),
                const Divider(height: 1),
                const SizedBox(
                  height: 120,
                  child: ProcessFlow(),
                ),
                const GameControls(),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showLevelCompleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Level Complete!"),
        content: const Text("Great job! You guided the train to the station."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Go to next level
              ref.read(gameProvider.notifier).nextLevel();
            },
            child: const Text("Next Level"),
          ),
        ],
      ),
    );
  }

  void _showCrashDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Ouch!"),
        content: const Text("The train crashed or went off track. Try again!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(gameProvider.notifier).resetGame();
            },
            child: const Text("Try Again"),
          ),
        ],
      ),
    );
  }
}
