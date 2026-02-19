import '../models/level.dart';

final List<Level> gameLevels = [
  Level(
    id: 1,
    name: "Level 1: Tiny Start",
    rows: 4,
    cols: 4,
    grid: List.generate(4, (r) => List.generate(4, (c) {
      if (r == 3 && c == 3) return TileType.station;
      if (r == 0 && c == 0) return TileType.start;
      return TileType.empty;
    })),
    startPosition: (0, 0),
  ),
  Level(
    id: 2,
    name: "Level 2: Slight Detour",
    rows: 4,
    cols: 4,
    grid: List.generate(4, (r) => List.generate(4, (c) {
      if (r == 3 && c == 3) return TileType.station;
      if (r == 0 && c == 0) return TileType.start;
      if ((r == 1 && c == 1) || (r == 2 && c == 1)) return TileType.obstacle;
      return TileType.empty;
    })),
    startPosition: (0, 0),
  ),
  Level(
    id: 3,
    name: "Level 3: Growing Up",
    rows: 5,
    cols: 5,
    grid: List.generate(5, (r) => List.generate(5, (c) {
      if (r == 4 && c == 4) return TileType.station;
      if (r == 0 && c == 0) return TileType.start;
      if (r == 2 && c > 0 && c < 4) return TileType.obstacle;
      return TileType.empty;
    })),
    startPosition: (0, 0),
  ),
  Level(
    id: 4,
    name: "Level 4: The Maze",
    rows: 6,
    cols: 6,
    grid: List.generate(6, (r) => List.generate(6, (c) {
      if (r == 5 && c == 5) return TileType.station;
      if (r == 0 && c == 0) return TileType.start;
      if (c == 2 && r < 5) return TileType.obstacle;
      if (c == 4 && r > 0) return TileType.obstacle;
      return TileType.empty;
    })),
    startPosition: (0, 0),
  ),
  Level(
    id: 5,
    name: "Level 5: The Big Journey",
    rows: 8,
    cols: 8,
    grid: List.generate(8, (r) => List.generate(8, (c) {
      if (r == 7 && c == 7) return TileType.station;
      if (r == 0 && c == 0) return TileType.start;
      if (r % 2 == 1 && c != 7) return TileType.obstacle;
      return TileType.empty;
    })),
    startPosition: (0, 0),
  ),
];
