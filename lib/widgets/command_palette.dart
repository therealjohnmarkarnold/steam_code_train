import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/command.dart';
import '../providers/game_provider.dart';

class CommandPalette extends ConsumerWidget {
  const CommandPalette({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDraggableCommand(Command.moveUp, ref),
          _buildDraggableCommand(Command.moveDown, ref),
          _buildDraggableCommand(Command.moveLeft, ref),
          _buildDraggableCommand(Command.moveRight, ref),
        ],
      ),
    );
  }

  Widget _buildDraggableCommand(Command command, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref.read(gameProvider.notifier).addCommand(command),
      child: Draggable<Command>(
        data: command,
        feedback: Material(
          color: Colors.transparent,
          child: _buildCommandIcon(command, isDragging: true),
        ),
        childWhenDragging: _buildCommandIcon(command, isPlaceholder: true),
        child: _buildCommandIcon(command),
      ),
    );
  }

  Widget _buildCommandIcon(Command command, {bool isDragging = false, bool isPlaceholder = false}) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: isPlaceholder ? Colors.grey[300] : Colors.blueAccent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDragging || isPlaceholder
            ? []
            : [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                )
              ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            command.icon,
            color: isPlaceholder ? Colors.grey : Colors.white,
            size: 30,
          ),
          const SizedBox(height: 2),
          Text(
            command.label,
            style: TextStyle(
              color: isPlaceholder ? Colors.grey : Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
