import 'package:equatable/equatable.dart';

enum TileType {
  empty,
  obstacle,
  start,
  station,
}

class Level extends Equatable {
  final int id;
  final String name;
  final int rows;
  final int cols;
  final List<List<TileType>> grid;
  final (int, int) startPosition; // (row, col)

  const Level({
    required this.id,
    required this.name,
    required this.rows,
    required this.cols,
    required this.grid,
    required this.startPosition,
  });

  factory Level.demo() {
    return Level(
      id: 1,
      name: "Level 1",
      rows: 8,
      cols: 8,
      grid: List.generate(
        8,
        (r) => List.generate(
          8,
          (c) {
            if (r == 7 && c == 7) return TileType.station;
            if (r == 0 && c == 0) return TileType.start;
            if (r == 3 && c == 3) return TileType.obstacle;
            return TileType.empty;
          },
        ),
      ),
      startPosition: (0, 0),
    );
  }

  @override
  List<Object?> get props => [id, name, rows, cols, grid, startPosition];
}
