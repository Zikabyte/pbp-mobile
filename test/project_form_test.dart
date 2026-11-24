// Widget tests for ProjectFormPage: validation, the login guard on submit,
// and a successful create flow against a fake backend.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:portfolio_mobile/features/auth/pages/login_page.dart';
import 'package:portfolio_mobile/features/projects/pages/project_form.dart';

import 'test_helpers.dart';

void main() {
  group('ProjectFormPage', () {
    testWidgets('shows validation errors when required fields are empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(wrapWithProviders(const ProjectFormPage()));

      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pump();

      expect(find.text('Judul proyek tidak boleh kosong!'), findsOneWidget);
      expect(find.text('Deskripsi proyek tidak boleh kosong!'), findsOneWidget);
      expect(find.text('Tautan tidak boleh kosong!'), findsOneWidget);
    });

    testWidgets('redirects to LoginPage when not authenticated', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(wrapWithProviders(const ProjectFormPage()));

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Judul Proyek'),
        'My Project',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Deskripsi Proyek'),
        'A project description.',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Tautan Proyek'),
        'https://example.com',
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets(
      'submits successfully when logged in and shows a summary dialog',
      (WidgetTester tester) async {
        final client = MockClient((request) async {
          if (request.method == 'POST') {
            return http.Response(
              '{"id": "uuid-1", "title": "My Project", '
              '"description": "A project description.", '
              '"tech_stack": "web-development", '
              '"project_url": "https://example.com", '
              '"project_image_url": ""}',
              201,
            );
          }
          return http.Response('[]', 200);
        });

        await tester.pumpWidget(
          wrapWithProviders(
            const ProjectFormPage(),
            client: client,
            initialToken: 'test-token',
          ),
        );

        await tester.enterText(
          find.widgetWithText(TextFormField, 'Judul Proyek'),
          'My Project',
        );
        await tester.enterText(
          find.widgetWithText(TextFormField, 'Deskripsi Proyek'),
          'A project description.',
        );
        await tester.enterText(
          find.widgetWithText(TextFormField, 'Tautan Proyek'),
          'https://example.com',
        );

        await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
        await tester.pumpAndSettle();

        expect(find.text('Proyek berhasil ditambahkan!'), findsOneWidget);
        expect(find.text('Judul: My Project'), findsOneWidget);
      },
    );

    testWidgets('shows a SnackBar when the server rejects the request', (
      WidgetTester tester,
    ) async {
      final client = MockClient((request) async {
        if (request.method == 'POST') {
          return http.Response('{"detail": "Forbidden"}', 403);
        }
        return http.Response('[]', 200);
      });

      await tester.pumpWidget(
        wrapWithProviders(
          const ProjectFormPage(),
          client: client,
          initialToken: 'test-token',
        ),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Judul Proyek'),
        'My Project',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Deskripsi Proyek'),
        'A project description.',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Tautan Proyek'),
        'https://example.com',
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pumpAndSettle();

      expect(
        find.textContaining('Gagal menyimpan proyek (403)'),
        findsOneWidget,
      );
    });
  });
}
