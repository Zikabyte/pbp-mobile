// Shared test harness: wraps a widget with the Provider tree (ApiClient,
// AuthState) the app expects, backed by a fake HTTP client so no real
// network calls are made during widget tests.

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:portfolio_mobile/core/services/api_client.dart';
import 'package:portfolio_mobile/core/services/auth_state.dart';
import 'package:provider/provider.dart';

/// An [http.Client] that always returns an empty JSON array, suitable as a
/// default stand-in for GET /api/v1/projects/ in tests that don't care
/// about the response body.
http.Client emptyProjectsClient() {
  return MockClient((request) async {
    return http.Response(
      '[]',
      200,
      headers: {'content-type': 'application/json'},
    );
  });
}

/// Wraps [home] in a [MaterialApp] with the [ApiClient]/[AuthState]
/// providers the app's widgets (LeftDrawer, MyHomePage, forms, ...) expect.
Widget wrapWithProviders(
  Widget home, {
  http.Client? client,
  String? initialToken,
}) {
  final apiClient = ApiClient(
    client: client ?? emptyProjectsClient(),
    baseUrl: 'http://test.local',
  );
  return MultiProvider(
    providers: [
      Provider<ApiClient>.value(value: apiClient),
      ChangeNotifierProvider<AuthState>(
        create: (_) => AuthState(apiClient, initialToken: initialToken),
      ),
    ],
    child: MaterialApp(home: home),
  );
}
