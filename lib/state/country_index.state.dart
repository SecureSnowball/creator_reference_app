import 'package:flutter/foundation.dart';
import 'package:test_app/models/country.model.dart';

class CountryIndexState extends ChangeNotifier {
  List<Country> _countries = [];
  List<Country> get countries => _countries;

  loadState(CountryPage countryPage) {
    _countries = countryPage.countries;
    notifyListeners();
  }

  clearState() {
    _countries.clear();
    notifyListeners();
  }
}
