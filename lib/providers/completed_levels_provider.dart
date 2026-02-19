import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

class CompletedLevelsNotifier extends Notifier<Set<int>> {
  static const String _key = 'completed_levels';

  @override
  Set<int> build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final list = prefs.getStringList(_key) ?? [];
    return list.map(int.parse).toSet();
  }

  void markComplete(int levelId) {
    if (!state.contains(levelId)) {
      final newState = Set<int>.from(state)..add(levelId);
      state = newState;
      _saveToPrefs();
    }
  }

  void _saveToPrefs() {
    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setStringList(_key, state.map((e) => e.toString()).toList());
  }
}

final completedLevelsProvider = NotifierProvider<CompletedLevelsNotifier, Set<int>>(CompletedLevelsNotifier.new);
