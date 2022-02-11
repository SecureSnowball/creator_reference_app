import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:test_app/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future setUser(final BuildContext context, final User user) async {
  final pref = await SharedPreferences.getInstance();
  return await pref.setString('user', json.encode(user.toTokenJson()));
}

Future getUser(final BuildContext context) async {
  final pref = await SharedPreferences.getInstance();
  final userString = pref.getString('user');
  if (userString != null) {
    final user = User.fromJson(json.decode(userString));
    return user;
  }
  return userString;
}

Future setToken(final BuildContext context, final String token) async {
  final pref = await SharedPreferences.getInstance();
  return await pref.setString('token', token);
}

Future<String?> getToken(final BuildContext context) async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString('token');
}

Future setTokenAndUser(
  final BuildContext context,
  final String token,
  final User user,
) async {
  final pref = await SharedPreferences.getInstance();
  return await Future.wait([
    pref.setString('user', json.encode(user.toTokenJson())),
    pref.setString('token', token),
  ]);
}

Future getTokenAndUser(final BuildContext context) async {
  final pref = await SharedPreferences.getInstance();
  final token = pref.getString('token');
  if (token != null) {
    final userString = pref.getString('user');
    final user = User.fromJson(json.decode(userString!));
    return {
      'user': user,
      'token': token,
    };
  }
  return {
    'user': null,
    'token': null,
  };
}

Future clearTokenAndUser(final BuildContext context) async {
  final pref = await SharedPreferences.getInstance();
  await pref.remove('token');
  await pref.remove('user');
}