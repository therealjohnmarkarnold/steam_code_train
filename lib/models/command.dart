import 'package:flutter/material.dart';

enum Direction {
  north,
  east,
  south,
  west;

  Direction get turnLeft {
    switch (this) {
      case Direction.north:
        return Direction.west;
      case Direction.east:
        return Direction.north;
      case Direction.south:
        return Direction.east;
      case Direction.west:
        return Direction.south;
    }
  }

  Direction get turnRight {
    switch (this) {
      case Direction.north:
        return Direction.east;
      case Direction.east:
        return Direction.south;
      case Direction.south:
        return Direction.west;
      case Direction.west:
        return Direction.north;
    }
  }

  Offset get vector {
    switch (this) {
      case Direction.north:
        return const Offset(0, -1);
      case Direction.east:
        return const Offset(1, 0);
      case Direction.south:
        return const Offset(0, 1);
      case Direction.west:
        return const Offset(-1, 0);
    }
  }
}

enum CommandType {
  moveForward,
  turnLeft,
  turnRight,
}

class Command {
  final String id;
  final CommandType type;
  final IconData icon;
  final String label;

  const Command({
    required this.id,
    required this.type,
    required this.icon,
    required this.label,
  });

  static const moveForward = Command(
    id: 'move_forward',
    type: CommandType.moveForward,
    icon: Icons.arrow_upward,
    label: 'Forward',
  );

  static const turnLeft = Command(
    id: 'turn_left',
    type: CommandType.turnLeft,
    icon: Icons.turn_left,
    label: 'Left',
  );

  static const turnRight = Command(
    id: 'turn_right',
    type: CommandType.turnRight,
    icon: Icons.turn_right,
    label: 'Right',
  );
}
