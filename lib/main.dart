import 'package:flutter/material.dart';
import 'package:portfolio_mobile/app.dart';
import 'package:portfolio_mobile/core/services/api_client.dart';
import 'package:portfolio_mobile/core/services/auth_state.dart';
import 'package:provider/provider.dart';

void main() {
  final apiClient = ApiClient();
  runApp(
    MultiProvider(
      providers: [
        Provider<ApiClient>.value(value: apiClient),
        ChangeNotifierProvider<AuthState>(create: (_) => AuthState(apiClient)),
      ],
      child: const App(),
    ),
  );
}
