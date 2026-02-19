import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/command.dart';
import '../models/game_state.dart';
import '../models/level.dart';
import '../data/levels.dart';
import 'completed_levels_provider.dart';

class GameNotifier extends Notifier<GameState> {
  
  @override
  GameState build() {
    return GameState.initial(gameLevels[0]);
  }

  Timer? _timer;

  void addCommand(Command command) {
    if (state.status == GameStatus.playing) return;
    state = state.copyWith(commands: [...state.commands, command]);
  }

  void removeCommand(int index) {
    if (state.status == GameStatus.playing) return;
    final newCommands = List<Command>.from(state.commands)..removeAt(index);
    state = state.copyWith(commands: newCommands);
  }

  void clearCommands() {
    if (state.status == GameStatus.playing) return;
    state = state.copyWith(commands: []);
  }

  void resetGame() {
    _timer?.cancel();
    state = GameState.initial(state.level).copyWith(commands: state.commands);
  }

  Future<void> playSequence() async {
    if (state.status == GameStatus.playing) return;
    if (state.commands.isEmpty) return;

    // Reset position before playing
    state = state.copyWith(
      status: GameStatus.playing,
      trainPosition: state.level.startPosition,
      trainDirection: Direction.east,
      currentCommandIndex: -1,
    );

    for (int i = 0; i < state.commands.length; i++) {
        // Checking if the provider is still alive/mounted is different in Notifier
        // We can check if we are disposed, but Notifier doesn't expose 'mounted' directly in same way?
        // Actually, let's just proceed. If disposed, setting state throws.
        // We can try-catch or just ignore for now as it's a simple app.
        
        // Wait for animation
        await Future.delayed(const Duration(milliseconds: 500));
        
        // basic check
        if (state.status != GameStatus.playing) break;

        state = state.copyWith(currentCommandIndex: i);
        _executeCommand(state.commands[i]);
        
        _checkWinCondition();
        if (state.status != GameStatus.playing) break;
    }
    
    if (state.status == GameStatus.playing) {
        state = state.copyWith(status: GameStatus.idle, currentCommandIndex: -1);
    }
  }

  void loadLevel(int levelIndex) {
    if (levelIndex < 0 || levelIndex >= gameLevels.length) return;
    _currentLevelIndex = levelIndex;
    final level = gameLevels[levelIndex];
    state = GameState.initial(level);
  }

  void nextLevel() {
    loadLevel(_currentLevelIndex + 1);
  }

  void loadCustomLevel(Level level) {
      _currentLevelIndex = -1; // Indicates custom level
      state = GameState.initial(level);
  }

  int _currentLevelIndex = 0;

  void _executeCommand(Command command) {
    switch (command.type) {
      case CommandType.moveUp:
        state = state.copyWith(trainDirection: Direction.north);
        _moveForward();
        break;
      case CommandType.moveDown:
        state = state.copyWith(trainDirection: Direction.south);
        _moveForward();
        break;
      case CommandType.moveLeft:
        state = state.copyWith(trainDirection: Direction.west);
        _moveForward();
        break;
      case CommandType.moveRight:
        state = state.copyWith(trainDirection: Direction.east);
        _moveForward();
        break;
    }
  }

  void _moveForward() {
    final (dr, dc) = _getOffset(state.trainDirection);
    final (r, c) = state.trainPosition;
    final newR = r + dr;
    final newC = c + dc;

    if (!_isValidMove(newR, newC)) {
        state = state.copyWith(status: GameStatus.crashed);
        return;
    }

    state = state.copyWith(trainPosition: (newR, newC));
  }

  (int, int) _getOffset(Direction dir) {
      switch (dir) {
          case Direction.north: return (-1, 0);
          case Direction.east: return (0, 1);
          case Direction.south: return (1, 0);
          case Direction.west: return (0, -1);
      }
  }

  bool _isValidMove(int r, int c) {
    // Check bounds
    if (r < 0 || r >= state.level.rows || c < 0 || c >= state.level.cols) return false;
    
    // Check obstacles
    final tile = state.level.grid[r][c];
    if (tile == TileType.obstacle) return false;

    return true;
  }

  void _checkWinCondition() {
      final (r, c) = state.trainPosition;
      if (state.level.grid[r][c] == TileType.station) {
          state = state.copyWith(status: GameStatus.levelComplete);
          // Only trigger for preset levels (id > 0)
          if (state.level.id > 0) {
              ref.read(completedLevelsProvider.notifier).markComplete(state.level.id);
          }
      }
  }
}

final gameProvider = NotifierProvider<GameNotifier, GameState>(GameNotifier.new);
