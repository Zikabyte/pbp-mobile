// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:portfolio_mobile/app.dart';

void main() {
  testWidgets('Home page shows profile info and menu actions', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify the profile info and menu actions are shown.
    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);

    // Tap a menu action and verify the SnackBar message appears.
    await tester.ensureVisible(find.text('Logout'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Logout'));
    await tester.pump();

    expect(find.text('Kamu telah menekan tombol Logout!'), findsOneWidget);
  });
}
