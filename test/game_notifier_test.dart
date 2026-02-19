import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_code_train/models/command.dart';
import 'package:steam_code_train/models/game_state.dart';
import 'package:steam_code_train/providers/game_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  test('Initial state is correct', () {
    final state = container.read(gameProvider);
    expect(state.status, GameStatus.idle);
    expect(state.commands, isEmpty);
    expect(state.trainPosition, (0, 0)); // Based on Level.demo or first level
    expect(state.trainDirection, Direction.east);
  });

  test('Add command updates state', () {
    container.read(gameProvider.notifier).addCommand(Command.moveUp);
    final state = container.read(gameProvider);
    expect(state.commands.length, 1);
    expect(state.commands.first, Command.moveUp);
  });

  test('Reset game clears state but keeps commands', () {
    container.read(gameProvider.notifier).addCommand(Command.moveUp);
    container.read(gameProvider.notifier).resetGame();
    final state = container.read(gameProvider);
    expect(state.commands.length, 1);
    expect(state.status, GameStatus.idle);
    expect(state.trainPosition, (0, 0));
  });
}
