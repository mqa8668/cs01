import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:neural_map_app/main.dart';

void main() {
  testWidgets('App launches with Neural Map screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: NeuralMapApp(),
      ),
    );

    // Pump a few frames to let the router settle (don't use pumpAndSettle
    // because we have infinite animations running)
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Verify the Neural Map title is present
    expect(find.text('Neural Map'), findsOneWidget);

    // Verify the navigation items are present
    expect(find.text('Neural'), findsOneWidget);
    expect(find.text('Test'), findsOneWidget);
    expect(find.text('Garden'), findsOneWidget);
    expect(find.text('Diary'), findsOneWidget);
    expect(find.text('Care'), findsOneWidget);
  });
}
