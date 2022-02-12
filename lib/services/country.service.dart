import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/config/constants.dart';
import 'package:test_app/models/country.model.dart';
import 'package:test_app/state/country_filter.state.dart';
import 'package:test_app/state/country_show.state.dart';
import 'package:test_app/state/country_index.state.dart';
import 'package:test_app/exceptions/unknown.exception.dart';
import 'package:test_app/services/http.service.dart' as http_service;

Future<CountryPage> index(final BuildContext context) async {
  const pageNo = 1;
  const pageSize = 1000;
  var url = baseUrl + '/api/country?page_no=$pageNo&page_size=$pageSize';
  final filter = context.read<CountryFilterState>();
  if (filter.name != null && filter.name != '') {
    url += '&name=${filter.name}';
  }
  if (filter.code != null && filter.code != '') {
    url += '&code=${filter.code}';
  }
  final response = await http_service.authorizedGet(
    context,
    url: url,
  );
  if (response!.statusCode != 200) {
    throw UnknownException();
  }
  final countryPage = CountryPage.fromJson(json.decode(response.body));
  Provider.of<CountryIndexState>(context, listen: false).loadState(countryPage);
  return countryPage;
}

Future<Country> show(final BuildContext context, final int countryId) async {
  final response = await http_service.authorizedGet(
    context,
    url: baseUrl + '/api/country/$countryId',
  );
  if (response!.statusCode != 200) {
    throw UnknownException();
  }
  final country = Country.fromJson(json.decode(response.body));
  Provider.of<CountryShowState>(context, listen: false).loadState(country);
  return country;
}
