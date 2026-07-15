import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tools_flutter/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Home shows Tools title (English)', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: ToolsApp()));
    await tester.pumpAndSettle();
    expect(find.text('Tools'), findsOneWidget);
    expect(find.text('Camera'), findsOneWidget);
    expect(find.text('Media Editor'), findsOneWidget);
  });

  testWidgets('Home switches to Chinese', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: ToolsApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.language));
    await tester.pumpAndSettle();
    await tester.tap(find.text('中文').last);
    await tester.pumpAndSettle();

    expect(find.text('Tools 工具箱'), findsOneWidget);
    expect(find.text('相机'), findsOneWidget);
    expect(find.text('媒体编辑'), findsOneWidget);
  });

  testWidgets('Home switches to French', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: ToolsApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.language));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Français').last);
    await tester.pumpAndSettle();

    expect(find.text('Caméra'), findsOneWidget);
    expect(find.text('Éditeur média'), findsOneWidget);
  });
}
