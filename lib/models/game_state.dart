import 'package:equatable/equatable.dart';
import 'command.dart';
import 'level.dart';

enum GameStatus {
  idle,
  playing,
  paused,
  levelComplete,
  crashed,
}

class GameState extends Equatable {
  final Level level;
  final (int, int) trainPosition;
  final Direction trainDirection;
  final List<Command> commands;
  final int currentCommandIndex;
  final GameStatus status;

  const GameState({
    required this.level,
    required this.trainPosition,
    required this.trainDirection,
    required this.commands,
    this.currentCommandIndex = -1,
    this.status = GameStatus.idle,
  });

  factory GameState.initial(Level level) {
    return GameState(
      level: level,
      trainPosition: level.startPosition,
      trainDirection: Direction.east,
      commands: const [],
    );
  }

  GameState copyWith({
    Level? level,
    (int, int)? trainPosition,
    Direction? trainDirection,
    List<Command>? commands,
    int? currentCommandIndex,
    GameStatus? status,
  }) {
    return GameState(
      level: level ?? this.level,
      trainPosition: trainPosition ?? this.trainPosition,
      trainDirection: trainDirection ?? this.trainDirection,
      commands: commands ?? this.commands,
      currentCommandIndex: currentCommandIndex ?? this.currentCommandIndex,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        level,
        trainPosition,
        trainDirection,
        commands,
        currentCommandIndex,
        status,
      ];
}
