// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:portfolio_mobile/features/auth/pages/login_page.dart';
import 'package:portfolio_mobile/features/home/pages/home_page.dart';

import 'test_helpers.dart';

void main() {
  testWidgets('Home page shows profile info and menu actions', (
    WidgetTester tester,
  ) async {
    // Build the home page with its provider dependencies and trigger a frame.
    await tester.pumpWidget(wrapWithProviders(MyHomePage()));

    // Verify the profile info and menu actions are shown.
    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
    // Not logged in by default, so the tile reads "Login".
    expect(find.text('Login'), findsOneWidget);

    // Tap the login menu action and verify it navigates to LoginPage.
    await tester.ensureVisible(find.text('Login'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
  });
}
