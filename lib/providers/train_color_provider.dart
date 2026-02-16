import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainColorNotifier extends Notifier<Color> {
  @override
  Color build() {
    return Colors.red;
  }

  void setColor(Color color) {
    state = color;
  }
}

final trainColorProvider = NotifierProvider<TrainColorNotifier, Color>(TrainColorNotifier.new);
