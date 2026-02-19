import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/levels.dart';
import '../providers/game_provider.dart';
import '../providers/completed_levels_provider.dart';
import 'game_screen.dart';
import 'level_editor_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Steam Code Train'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const LevelEditorScreen()),
                      );
                    },
                    icon: const Icon(Icons.build),
                    label: const Text('Build a Map'),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: gameLevels.length,
                itemBuilder: (context, index) {
                  final level = gameLevels[index];
                  final isCompleted = ref.watch(completedLevelsProvider).contains(level.id);

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: const Icon(Icons.play_circle_fill, color: Colors.blueAccent, size: 40),
                      title: Text(level.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text('${level.rows}x${level.cols} Map'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isCompleted)
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.check_circle, color: Colors.green),
                            ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                      onTap: () {
                        ref.read(gameProvider.notifier).loadLevel(index);
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const GameScreen()),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
