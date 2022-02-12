import 'package:flutter/foundation.dart';
import 'package:test_app/models/country.model.dart';

class CountryShowState extends ChangeNotifier {
  Country? _country;
  Country? get country => _country;

  loadState(Country country) {
    _country = country;
    notifyListeners();
  }

  clearState() {
    _country = null;
    notifyListeners();
  }
}
