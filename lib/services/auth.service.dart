import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:test_app/config/constants.dart';
import 'package:test_app/state/auth.state.dart';
import 'package:test_app/models/user.model.dart';
import 'package:test_app/exceptions/unknown.exception.dart';
import 'package:test_app/interfaces/auth/login.interface.dart';
import 'package:test_app/interfaces/auth/register.interface.dart';
import 'package:test_app/services/http.service.dart' as http_service;
import 'package:test_app/services/sharedPreference.service.dart'
    as persist_service;

// Loads status from share preferences
Future bootstrap(final BuildContext context) async {
  final tokenAndUser = await persist_service.getTokenAndUser(context);
  if (tokenAndUser['token'] != null) {
    Provider.of<AuthState>(context, listen: false)
        .loadState(tokenAndUser['token'], tokenAndUser['user']);
  }
}

Future register(
  final BuildContext context,
  final RegisterRequest input,
) async {
  const url = baseUrl + '/api/register';
  final response = await http_service.post(
    url: url,
    context: context,
    body: input.toJson(),
  );
  if (response!.statusCode != 200) throw UnknownException();
  final Map<String, dynamic> resposneMap = json.decode(response.body);
  final user = User.fromJson(resposneMap['user']);
  final String token = resposneMap['token'];
  await persist_service.setTokenAndUser(context, token, user);
  Provider.of<AuthState>(context, listen: false).loadState(token, user);
}

Future login(
  final BuildContext context,
  final LoginRequest input,
) async {
  const url = baseUrl + '/api/login';
  final response = await http_service.post(
    url: url,
    context: context,
    body: input.toJson(),
  );
  if (response!.statusCode != 200) throw UnknownException();
  final Map<String, dynamic> resposneMap = json.decode(response.body);
  final user = User.fromJson(resposneMap['user']);
  final String token = resposneMap['token'];
  await persist_service.setTokenAndUser(context, token, user);
  Provider.of<AuthState>(context, listen: false).loadState(token, user);
}

Future logout(final BuildContext context) async {
  try {
    const url = baseUrl + '/api/logout';
    await http_service.post(
      url: url,
      context: context,
    );
  } catch (_) {}
  await persist_service.clearTokenAndUser(context);

  Provider.of<AuthState>(context, listen: false).clearState();
}