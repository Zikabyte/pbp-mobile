// Widget tests for LeftDrawer: menu items are present and each one
// navigates to the right page (Home, View Projects, Add Project, Add
// Experience), with "Add Project" gated behind login.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:portfolio_mobile/features/auth/pages/login_page.dart';
import 'package:portfolio_mobile/features/experiences/pages/experience_form.dart';
import 'package:portfolio_mobile/features/home/pages/home_page.dart';
import 'package:portfolio_mobile/features/projects/pages/project_form.dart';
import 'package:portfolio_mobile/features/projects/pages/project_list_page.dart';

import 'test_helpers.dart';

void main() {
  Future<void> openDrawer(WidgetTester tester) async {
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
  }

  // "Login"/"Logout" also appear as a tile on the home page grid behind the
  // open drawer, so scope these finders to inside the Drawer itself.
  Finder inDrawer(String text) =>
      find.descendant(of: find.byType(Drawer), matching: find.text(text));

  group('LeftDrawer', () {
    testWidgets('shows the header and all menu items', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(wrapWithProviders(MyHomePage()));

      await openDrawer(tester);

      expect(find.text('My Portfolio'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('View Projects'), findsOneWidget);
      expect(find.text('Add Project'), findsOneWidget);
      expect(find.text('Add Experience'), findsOneWidget);
      // Not logged in by default: shows "Login", not "Logout".
      expect(inDrawer('Login'), findsOneWidget);
      expect(inDrawer('Logout'), findsNothing);
    });

    testWidgets('tapping "View Projects" navigates to ProjectListPage', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(wrapWithProviders(MyHomePage()));

      await openDrawer(tester);
      await tester.tap(find.text('View Projects'));
      await tester.pumpAndSettle();

      expect(find.byType(ProjectListPage), findsOneWidget);
    });

    testWidgets(
      'tapping "Add Project" while logged out redirects to LoginPage',
      (WidgetTester tester) async {
        await tester.pumpWidget(wrapWithProviders(MyHomePage()));

        await openDrawer(tester);
        await tester.tap(find.text('Add Project'));
        await tester.pumpAndSettle();

        expect(find.byType(LoginPage), findsOneWidget);
        expect(find.byType(ProjectFormPage), findsNothing);
      },
    );

    testWidgets(
      'tapping "Add Project" while logged in navigates to ProjectFormPage',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          wrapWithProviders(MyHomePage(), initialToken: 'test-token'),
        );

        await openDrawer(tester);
        await tester.tap(find.text('Add Project'));
        await tester.pumpAndSettle();

        expect(find.byType(ProjectFormPage), findsOneWidget);
      },
    );

    testWidgets('tapping "Add Experience" navigates to ExperienceFormPage', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(wrapWithProviders(MyHomePage()));

      await openDrawer(tester);
      await tester.tap(find.text('Add Experience'));
      await tester.pumpAndSettle();

      expect(find.byType(ExperienceFormPage), findsOneWidget);
      expect(find.text('Add Experience Form'), findsOneWidget);
    });

    testWidgets(
      'tapping "Home" from the experience form returns to MyHomePage',
      (WidgetTester tester) async {
        await tester.pumpWidget(wrapWithProviders(const ExperienceFormPage()));

        await openDrawer(tester);
        await tester.tap(find.text('Home'));
        await tester.pumpAndSettle();

        expect(find.byType(MyHomePage), findsOneWidget);
        expect(find.byType(ExperienceFormPage), findsNothing);
      },
    );

    testWidgets('shows "Logout" and tapping it clears the session', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapWithProviders(MyHomePage(), initialToken: 'test-token'),
      );

      await openDrawer(tester);
      expect(inDrawer('Logout'), findsOneWidget);
      expect(inDrawer('Login'), findsNothing);

      await tester.tap(inDrawer('Logout'));
      await tester.pump();

      expect(find.text('Kamu telah logout.'), findsOneWidget);
    });
  });
}
