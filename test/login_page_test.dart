// Widget tests for LoginPage: validation, successful login pops the route
// with `true`, and a failed login shows an error SnackBar without popping.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:portfolio_mobile/core/services/auth_state.dart';
import 'package:portfolio_mobile/features/auth/pages/login_page.dart';
import 'package:provider/provider.dart';

import 'test_helpers.dart';

void main() {
  group('LoginPage', () {
    testWidgets('shows validation errors when fields are empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(wrapWithProviders(const LoginPage()));

      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();

      expect(find.text('Username cannot be empty!'), findsOneWidget);
      expect(find.text('Password cannot be empty!'), findsOneWidget);
    });

    testWidgets('logs in successfully and pops with true', (
      WidgetTester tester,
    ) async {
      final client = MockClient((request) async {
        return http.Response('{"token": "abc123"}', 200);
      });

      bool? poppedValue;
      late BuildContext capturedContext;

      await tester.pumpWidget(
        wrapWithProviders(
          Builder(
            builder: (innerContext) {
              capturedContext = innerContext;
              return ElevatedButton(
                onPressed: () async {
                  poppedValue = await Navigator.push<bool>(
                    innerContext,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                },
                child: const Text('open login'),
              );
            },
          ),
          client: client,
        ),
      );

      await tester.tap(find.text('open login'));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Username'),
        'zidane',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'secret',
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsNothing);
      expect(poppedValue, isTrue);
      expect(capturedContext.read<AuthState>().isLoggedIn, isTrue);
    });

    testWidgets('shows a SnackBar and stays on the page on failure', (
      WidgetTester tester,
    ) async {
      final client = MockClient((request) async {
        return http.Response('{"detail": "invalid"}', 400);
      });

      await tester.pumpWidget(
        wrapWithProviders(const LoginPage(), client: client),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Username'),
        'zidane',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'wrong',
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();
      await tester.pump();

      expect(find.textContaining('Login failed'), findsOneWidget);
      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
