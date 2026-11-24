// Unit tests for AuthState: login stores the token and notifies listeners,
// logout clears it even if the server call fails.

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:portfolio_mobile/core/services/api_client.dart';
import 'package:portfolio_mobile/core/services/auth_state.dart';

void main() {
  group('AuthState', () {
    test('login stores the obtained token and notifies listeners', () async {
      final client = MockClient((request) async {
        expect(request.url.path, '/api/v1/auth/token/');
        return http.Response('{"token": "abc123"}', 200);
      });
      final authState = AuthState(
        ApiClient(client: client, baseUrl: 'http://test.local'),
      );

      var notified = false;
      authState.addListener(() => notified = true);

      expect(authState.isLoggedIn, isFalse);
      await authState.login('zidane', 'secret');

      expect(authState.isLoggedIn, isTrue);
      expect(authState.token, 'abc123');
      expect(notified, isTrue);
    });

    test('login throws ApiException on invalid credentials', () async {
      final client = MockClient((request) async {
        return http.Response('{"detail": "Invalid credentials"}', 400);
      });
      final authState = AuthState(
        ApiClient(client: client, baseUrl: 'http://test.local'),
      );

      expect(
        () => authState.login('zidane', 'wrong'),
        throwsA(isA<ApiException>()),
      );
      expect(authState.isLoggedIn, isFalse);
    });

    test('logout clears the token even if the API call fails', () async {
      final client = MockClient((request) async {
        return http.Response('', 401);
      });
      final authState = AuthState(
        ApiClient(client: client, baseUrl: 'http://test.local'),
        initialToken: 'existing-token',
      );

      expect(authState.isLoggedIn, isTrue);
      await authState.logout();

      expect(authState.isLoggedIn, isFalse);
      expect(authState.token, isNull);
    });

    test('logout is a no-op when already logged out', () async {
      var callCount = 0;
      final client = MockClient((request) async {
        callCount++;
        return http.Response('', 204);
      });
      final authState = AuthState(
        ApiClient(client: client, baseUrl: 'http://test.local'),
      );

      await authState.logout();

      expect(callCount, 0);
      expect(authState.isLoggedIn, isFalse);
    });
  });
}
