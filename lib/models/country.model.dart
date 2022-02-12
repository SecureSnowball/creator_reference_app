import 'package:test_app/models/pagination_meta.dart';

class Country {
  final int id;
  final String name;

  Country({
    required this.id,
    required this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CountryPage {
  final List<Country> countries;
  final PaginationMeta meta;

  CountryPage({
    required this.countries,
    required this.meta,
  });

  factory CountryPage.fromJson(Map<String, dynamic> json) {
    final List<Country> cities = [];
    for (final countryMap in json["data"]) {
      cities.add(Country.fromJson(countryMap));
    }
    return CountryPage(
      countries: cities,
      meta: PaginationMeta.fromJson(json),
    );
  }
}
