import 'package:flutter/material.dart';
import '../models/level.dart';

class GridTileWidget extends StatelessWidget {
  final TileType type;
  final int row;
  final int col;

  const GridTileWidget({
    super.key,
    required this.type,
    required this.row,
    required this.col,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData? icon;

    switch (type) {
      case TileType.empty:
      case TileType.start:
        color = (row + col) % 2 == 0 ? Colors.lightGreen[200]! : Colors.lightGreen[300]!;
        break;
      case TileType.obstacle:
        color = Colors.grey[700]!;
        icon = Icons.landscape;
        break;
      case TileType.station:
        color = Colors.blue[300]!;
        icon = Icons.home_filled;
        break;
    }

    // Start tile logic
    if (type == TileType.start) {
        icon = Icons.flag;
    }

    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: icon != null
          ? Icon(
              icon,
              color: Colors.white,
              size: 24,
            )
          : null,
    );
  }
}
