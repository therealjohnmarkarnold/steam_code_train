import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_code_train/screens/game_screen.dart';

void main() {
  testWidgets('GameScreen renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: GameScreen(),
        ),
      ),
    );

    // Verify that the title is present
    expect(find.text('Steam Code Train'), findsOneWidget);

    // Verify that the Grid is present (Game Board)
    expect(find.byType(GridView), findsOneWidget);

    // Verify that Command Palette is present (Drag targets)
    expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
    expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward), findsOneWidget);

    // Verify navigation buttons in AppBar
    expect(find.byIcon(Icons.build), findsOneWidget); // Level Editor
    expect(find.byIcon(Icons.palette), findsOneWidget); // Customization
  });

  testWidgets('Level Editor button navigates', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: GameScreen(),
        ),
      ),
    );

    // Tap the Level Editor button
    await tester.tap(find.byIcon(Icons.build));
    await tester.pumpAndSettle();

    // Verify we are on Level Editor screen
    expect(find.text('Level Editor'), findsOneWidget);
    expect(find.text('Drag tiles below onto map, tap map tiles to remove'), findsOneWidget);
  });
}
