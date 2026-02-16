import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/level.dart';
import '../providers/game_provider.dart';
import '../widgets/grid_tile_widget.dart';

class LevelEditorScreen extends ConsumerStatefulWidget {
  const LevelEditorScreen({super.key});

  @override
  ConsumerState<LevelEditorScreen> createState() => _LevelEditorScreenState();
}

class _LevelEditorScreenState extends ConsumerState<LevelEditorScreen> {
  late List<List<TileType>> _grid;
  final int _rows = 8;
  final int _cols = 8;

  @override
  void initState() {
    super.initState();
    // Initialize with empty grid
    _grid = List.generate(_rows, (_) => List.filled(_cols, TileType.empty));
    // Default start and end
    _grid[0][0] = TileType.start;
    _grid[7][7] = TileType.station;
  }

  void _cycleTile(int r, int c) {
    setState(() {
      final current = _grid[r][c];
      TileType next;
      switch (current) {
        case TileType.empty:
          next = TileType.obstacle;
          break;
        case TileType.obstacle:
          next = TileType.start;
          break;
        case TileType.start:
          next = TileType.station;
          break;
        case TileType.station:
          next = TileType.empty;
          break;
      }
      
      // Validation: Ensure only one Start and one Station
      if (next == TileType.start) {
        // Clear other starts
        for (var i = 0; i < _rows; i++) {
          for (var j = 0; j < _cols; j++) {
            if (_grid[i][j] == TileType.start) _grid[i][j] = TileType.empty;
          }
        }
      }
      if (next == TileType.station) {
         // Clear other stations
        for (var i = 0; i < _rows; i++) {
          for (var j = 0; j < _cols; j++) {
            if (_grid[i][j] == TileType.station) _grid[i][j] = TileType.empty;
          }
        }
      }

      _grid[r][c] = next;
    });
  }

  void _testLevel() {
    // Find start position
    (int, int)? startPos;
    bool hasStation = false;

    for (var i = 0; i < _rows; i++) {
        for (var j = 0; j < _cols; j++) {
            if (_grid[i][j] == TileType.start) startPos = (i, j);
            if (_grid[i][j] == TileType.station) hasStation = true;
        }
    }

    if (startPos == null || !hasStation) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Level must have a Start and a Station!")),
        );
        return;
    }

    final level = Level(
        id: 999,
        name: "Custom Level",
        rows: _rows,
        cols: _cols,
        grid: _grid,
        startPosition: startPos,
    );

    ref.read(gameProvider.notifier).loadCustomLevel(level);
    Navigator.of(context).pop(); // Go back to game screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Level Editor"),
        backgroundColor: Colors.orangeAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: _testLevel,
            tooltip: "Test Level",
          )
        ],
      ),
      body: Column(
        children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Tap tiles to cycle: Empty -> Obstacle -> Start -> Station"),
            ),
            Expanded(
                child: GridView.builder(
                    itemCount: _rows * _cols,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _cols,
                    ),
                    itemBuilder: (context, index) {
                        final r = index ~/ _cols;
                        final c = index % _cols;
                        return GestureDetector(
                            onTap: () => _cycleTile(r, c),
                            child: GridTileWidget(
                                type: _grid[r][c],
                                row: r,
                                col: c,
                            ),
                        );
                    },
                ),
            ),
        ],
      ),
    );
  }
}
