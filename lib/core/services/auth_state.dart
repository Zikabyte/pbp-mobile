import 'package:flutter/foundation.dart';
import 'package:portfolio_mobile/core/services/api_client.dart';

class AuthState extends ChangeNotifier {
  AuthState(this._apiClient, {String? initialToken}) : _token = initialToken;

  final ApiClient _apiClient;
  String? _token;

  String? get token => _token;
  bool get isLoggedIn => _token != null;

  Future<void> login(String username, String password) async {
    _token = await _apiClient.obtainToken(username, password);
    notifyListeners();
  }

  Future<void> logout() async {
    final current = _token;
    if (current == null) return;

    try {
      await _apiClient.logout(token: current);
    } on ApiException {
      // Token may already be invalid/expired server-side; still clear it
      // locally so the user is not stuck in a logged-in UI state.
    } finally {
      _token = null;
      notifyListeners();
    }
  }
}
