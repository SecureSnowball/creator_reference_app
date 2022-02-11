import 'package:flutter/foundation.dart';
import 'package:test_app/models/user.model.dart';

class AuthState extends ChangeNotifier {
  String? token;
  User? user;

  loadState(
    final String token,
    final User user,
  ) {
    this.token = token;
    this.user = user;
    notifyListeners();
  }

  clearState() {
    token = null;
    user = null;
    notifyListeners();
  }

  updateToken(final String token) {
    this.token = token;
    notifyListeners();
  }

  updateUser(final User user) {
    this.user = user;
    notifyListeners();
  }
}