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
  moveUp,
  moveDown,
  moveLeft,
  moveRight,
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

  static const moveUp = Command(
    id: 'move_up',
    type: CommandType.moveUp,
    icon: Icons.arrow_upward,
    label: 'Up',
  );

  static const moveDown = Command(
    id: 'move_down',
    type: CommandType.moveDown,
    icon: Icons.arrow_downward,
    label: 'Down',
  );

  static const moveLeft = Command(
    id: 'move_left',
    type: CommandType.moveLeft,
    icon: Icons.arrow_back,
    label: 'Left',
  );

  static const moveRight = Command(
    id: 'move_right',
    type: CommandType.moveRight,
    icon: Icons.arrow_forward,
    label: 'Right',
  );
}
