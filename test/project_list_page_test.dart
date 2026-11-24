// Widget tests for ProjectListPage: loading, populated list with navigation
// to the detail page, empty state, and the error/retry path.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:portfolio_mobile/features/projects/pages/project_detail_page.dart';
import 'package:portfolio_mobile/features/projects/pages/project_list_page.dart';

import 'test_helpers.dart';

void main() {
  group('ProjectListPage', () {
    testWidgets('shows projects and navigates to the detail page on tap', (
      WidgetTester tester,
    ) async {
      final client = MockClient((request) async {
        return http.Response(
          '[{"id": "uuid-1", "title": "Portfolio Site", '
          '"description": "My site", "tech_stack": "web-development", '
          '"project_url": "https://example.com", "project_image_url": ""}]',
          200,
        );
      });

      await tester.pumpWidget(
        wrapWithProviders(const ProjectListPage(), client: client),
      );
      await tester.pumpAndSettle();

      expect(find.text('Portfolio Site'), findsOneWidget);

      await tester.tap(find.text('Portfolio Site'));
      await tester.pumpAndSettle();

      expect(find.byType(ProjectDetailPage), findsOneWidget);
    });

    testWidgets('shows an empty state message when there are no projects', (
      WidgetTester tester,
    ) async {
      final client = MockClient((request) async {
        return http.Response('[]', 200);
      });

      await tester.pumpWidget(
        wrapWithProviders(const ProjectListPage(), client: client),
      );
      await tester.pumpAndSettle();

      expect(find.text('No projects found.'), findsOneWidget);
    });

    testWidgets('shows an error with a retry button on failure', (
      WidgetTester tester,
    ) async {
      final client = MockClient((request) async {
        return http.Response('Internal Server Error', 500);
      });

      await tester.pumpWidget(
        wrapWithProviders(const ProjectListPage(), client: client),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('Failed to load projects'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Retry'), findsOneWidget);
    });
  });
}
