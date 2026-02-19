import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/command.dart';
import '../providers/game_provider.dart';

class ProcessFlow extends ConsumerWidget {
  const ProcessFlow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);
    final commands = gameState.commands;
    final activeIndex = gameState.currentCommandIndex;

    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.blueGrey[50],
      child: Row(
        children: [
          Expanded(
            child: DragTarget<Command>(
              onAcceptWithDetails: (details) {
                ref.read(gameProvider.notifier).addCommand(details.data);
              },
              builder: (context, candidateData, rejectedData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: commands.length + 1, // +1 for the drop target area at the end
                  itemBuilder: (context, index) {
                    if (index == commands.length) {
                       // Drop target placeholder at the end
                       return Container(
                         width: 60,
                         margin: const EdgeInsets.all(4),
                         decoration: BoxDecoration(
                           color: candidateData.isNotEmpty ? Colors.blue.withValues(alpha: 0.3) : Colors.transparent,
                           borderRadius: BorderRadius.circular(8),
                           border: Border.all(color: Colors.grey[300]!, width: 2, style: BorderStyle.solid),
                         ),
                         child: Center(
                           child: Icon(Icons.add, color: Colors.grey),
                         ),
                       );
                    }

                    final command = commands[index];
                    final isActive = index == activeIndex;
                    
                    return GestureDetector(
                      onTap: () {
                         // Optional: remove on tap if not playing
                         ref.read(gameProvider.notifier).removeCommand(index);
                      },
                      child: Container(
                        width: 60,
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isActive ? Colors.orange : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isActive ? Colors.deepOrange : Colors.grey[400]!, 
                            width: isActive ? 3 : 1
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              offset: const Offset(1, 1),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(command.icon, color: Colors.black87),
                            Text(
                                command.label, 
                                style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
