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

  void _setTile(int r, int c, TileType next) {
    setState(() {
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
                child: Text("Drag tiles below onto map, tap map tiles to remove"),
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
                        return DragTarget<TileType>(
                            onAcceptWithDetails: (details) {
                                _setTile(r, c, details.data);
                            },
                            builder: (context, candidateData, rejectedData) {
                                return GestureDetector(
                                    onTap: () => _setTile(r, c, TileType.empty),
                                    child: GridTileWidget(
                                        type: _grid[r][c],
                                        row: r,
                                        col: c,
                                    ),
                                );
                            },
                        );
                    },
                ),
            ),
            const Divider(height: 1),
            Container(
                height: 80,
                color: Colors.grey[200],
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        _buildDraggableTile(TileType.obstacle),
                        _buildDraggableTile(TileType.start),
                        _buildDraggableTile(TileType.station),
                    ],
                ),
            ),
        ],
      ),
    );
  }

  Widget _buildDraggableTile(TileType type) {
    return Draggable<TileType>(
      data: type,
      feedback: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: 50,
          height: 50,
          child: GridTileWidget(type: type, row: 0, col: 0),
        ),
      ),
      child: SizedBox(
        width: 60,
        height: 60,
        child: GridTileWidget(type: type, row: 0, col: 0),
      ),
    );
  }
}
