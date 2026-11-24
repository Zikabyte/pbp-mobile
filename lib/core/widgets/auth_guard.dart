import 'package:flutter/material.dart';
import 'package:portfolio_mobile/core/services/auth_state.dart';
import 'package:portfolio_mobile/features/auth/pages/login_page.dart';
import 'package:provider/provider.dart';

Future<bool> ensureLoggedIn(BuildContext context) async {
  if (context.read<AuthState>().isLoggedIn) {
    return true;
  }
  final loggedIn = await Navigator.push<bool>(
    context,
    MaterialPageRoute(builder: (context) => const LoginPage()),
  );
  return loggedIn ?? false;
}
