import '../models/level.dart';

final List<Level> gameLevels = [
  Level(
    id: 1,
    name: "Level 1: The Beginning",
    rows: 8,
    cols: 8,
    grid: List.generate(8, (r) => List.generate(8, (c) {
      if (r == 7 && c == 7) return TileType.station;
      if (r == 0 && c == 0) return TileType.start;
      if (r == 3 && c == 3) return TileType.obstacle;
      return TileType.empty;
    })),
    startPosition: (0, 0),
  ),
  Level(
    id: 2,
    name: "Level 2: The Blockade",
    rows: 8,
    cols: 8,
    grid: List.generate(8, (r) => List.generate(8, (c) {
      if (r == 7 && c == 7) return TileType.station;
      if (r == 0 && c == 0) return TileType.start;
      if (c == 4 && r > 2 && r < 6) return TileType.obstacle; // Wall
      return TileType.empty;
    })),
    startPosition: (0, 0),
  ),
  Level(
    id: 3,
    name: "Level 3: The Maze",
    rows: 8,
    cols: 8,
    grid: List.generate(8, (r) => List.generate(8, (c) {
      if (r == 7 && c == 7) return TileType.station;
      if (r == 0 && c == 0) return TileType.start;
      if (r % 2 == 1 && c != 7) return TileType.obstacle; // Horizontal walls
      return TileType.empty;
    })),
    startPosition: (0, 0),
  ),
];
