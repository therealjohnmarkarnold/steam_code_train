import 'package:flutter/material.dart';
import '../models/command.dart';

class CommandPalette extends StatelessWidget {
  const CommandPalette({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDraggableCommand(Command.moveForward),
          _buildDraggableCommand(Command.turnLeft),
          _buildDraggableCommand(Command.turnRight),
        ],
      ),
    );
  }

  Widget _buildDraggableCommand(Command command) {
    return Draggable<Command>(
      data: command,
      feedback: Material(
        color: Colors.transparent,
        child: _buildCommandIcon(command, isDragging: true),
      ),
      childWhenDragging: _buildCommandIcon(command, isPlaceholder: true),
      child: _buildCommandIcon(command),
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
