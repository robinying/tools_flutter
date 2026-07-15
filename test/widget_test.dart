import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tools_flutter/main.dart';

void main() {
  testWidgets('Home shows Tools title', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: ToolsApp()));
    await tester.pumpAndSettle();
    expect(find.text('Tools'), findsOneWidget);
    expect(find.text('Camera'), findsOneWidget);
    expect(find.text('Media Editor'), findsOneWidget);
  });
}
