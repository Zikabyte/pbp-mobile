// Widget tests for ExperienceFormPage: field rendering, validation,
// the optional "ended at" date picker, and the success dialog flow.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:portfolio_mobile/features/experiences/pages/experience_form.dart';

import 'test_helpers.dart';

void main() {
  Future<void> pumpForm(WidgetTester tester) async {
    await tester.pumpWidget(wrapWithProviders(const ExperienceFormPage()));
  }

  group('ExperienceFormPage', () {
    testWidgets('renders all fields with the default category selected', (
      WidgetTester tester,
    ) async {
      await pumpForm(tester);

      expect(find.text('Add Experience Form'), findsOneWidget);
      // The label and hint text are identical for these two fields, so
      // both the floating label and the hint render the same string.
      expect(find.text('Judul Pengalaman'), findsAtLeastNWidgets(1));
      expect(find.text('Deskripsi Pengalaman'), findsAtLeastNWidgets(1));
      expect(find.text('Kategori Pengalaman'), findsOneWidget);
      expect(find.text('Tautan Thumbnail'), findsOneWidget);
      expect(find.text('Full-Time'), findsOneWidget);
      expect(find.text('Masih berlangsung'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Save'), findsOneWidget);
    });

    testWidgets('shows validation errors when required fields are empty', (
      WidgetTester tester,
    ) async {
      await pumpForm(tester);

      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pump();

      expect(find.text('Judul pengalaman tidak boleh kosong!'), findsOneWidget);
      expect(
        find.text('Deskripsi pengalaman tidak boleh kosong!'),
        findsOneWidget,
      );
      // No success dialog should appear.
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('rejects an invalid thumbnail URL', (
      WidgetTester tester,
    ) async {
      await pumpForm(tester);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Judul Pengalaman').first,
        'Software Engineer Intern',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Deskripsi Pengalaman').first,
        'Worked on the mobile app.',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Tautan Thumbnail'),
        'not-a-valid-url',
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pump();

      expect(
        find.text('Tautan thumbnail harus berupa URL yang valid!'),
        findsOneWidget,
      );
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets(
      'submits successfully and shows a summary dialog, then resets the form',
      (WidgetTester tester) async {
        await pumpForm(tester);

        await tester.enterText(
          find.widgetWithText(TextFormField, 'Judul Pengalaman').first,
          'Software Engineer Intern',
        );
        await tester.enterText(
          find.widgetWithText(TextFormField, 'Deskripsi Pengalaman').first,
          'Worked on the mobile app.',
        );
        await tester.enterText(
          find.widgetWithText(TextFormField, 'Tautan Thumbnail'),
          'https://example.com/thumbnail.png',
        );

        await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
        await tester.pump();

        expect(find.text('Pengalaman berhasil ditambahkan!'), findsOneWidget);
        expect(find.text('Judul: Software Engineer Intern'), findsOneWidget);
        expect(
          find.text('Deskripsi: Worked on the mobile app.'),
          findsOneWidget,
        );
        expect(find.text('Kategori: Full-Time'), findsOneWidget);
        expect(
          find.text('Thumbnail: https://example.com/thumbnail.png'),
          findsOneWidget,
        );
        expect(find.text('Status: Masih berlangsung'), findsOneWidget);

        await tester.tap(find.widgetWithText(TextButton, 'OK'));
        await tester.pump();

        expect(find.byType(AlertDialog), findsNothing);
        expect(
          find.widgetWithText(TextFormField, 'Judul Pengalaman').first,
          findsOneWidget,
        );
      },
    );

    testWidgets('allows an empty thumbnail since it is optional', (
      WidgetTester tester,
    ) async {
      await pumpForm(tester);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Judul Pengalaman').first,
        'Research Assistant',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Deskripsi Pengalaman').first,
        'Helped with data analysis.',
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pump();

      expect(find.text('Pengalaman berhasil ditambahkan!'), findsOneWidget);
      expect(find.text('Thumbnail: -'), findsOneWidget);
    });

    testWidgets('picking an ended-at date shows it and allows clearing it', (
      WidgetTester tester,
    ) async {
      await pumpForm(tester);

      await tester.tap(find.text('Masih berlangsung'));
      await tester.pumpAndSettle();

      // The Material date picker dialog should now be open.
      expect(find.byType(DatePickerDialog), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      // A date has been picked, so "Masih berlangsung" text is gone
      // and a clear icon button is shown instead of the calendar icon.
      expect(find.text('Masih berlangsung'), findsNothing);
      expect(find.byIcon(Icons.clear), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today), findsNothing);

      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();

      expect(find.text('Masih berlangsung'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    });
  });
}
