// Widget tests for LeftDrawer: menu items are present and each one
// navigates to the right page (Home, Add Project, Add Experience).

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:portfolio_mobile/features/experiences/pages/experience_form.dart';
import 'package:portfolio_mobile/features/home/pages/home_page.dart';
import 'package:portfolio_mobile/features/projects/pages/project_form.dart';

void main() {
  Future<void> openDrawer(WidgetTester tester) async {
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
  }

  group('LeftDrawer', () {
    testWidgets('shows the header and all menu items', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: MyHomePage()));

      await openDrawer(tester);

      expect(find.text('My Portfolio'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Add Project'), findsOneWidget);
      expect(find.text('Add Experience'), findsOneWidget);
    });

    testWidgets('tapping "Add Experience" navigates to ExperienceFormPage', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: MyHomePage()));

      await openDrawer(tester);
      await tester.tap(find.text('Add Experience'));
      await tester.pumpAndSettle();

      expect(find.byType(ExperienceFormPage), findsOneWidget);
      expect(find.text('Add Experience Form'), findsOneWidget);
    });

    testWidgets('tapping "Add Project" navigates to ProjectFormPage', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: MyHomePage()));

      await openDrawer(tester);
      await tester.tap(find.text('Add Project'));
      await tester.pumpAndSettle();

      expect(find.byType(ProjectFormPage), findsOneWidget);
      expect(find.text('Add Project Form'), findsOneWidget);
    });

    testWidgets('tapping "Home" from the experience form returns to MyHomePage', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: const ExperienceFormPage()));

      await openDrawer(tester);
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      expect(find.byType(MyHomePage), findsOneWidget);
      expect(find.byType(ExperienceFormPage), findsNothing);
    });
  });
}
