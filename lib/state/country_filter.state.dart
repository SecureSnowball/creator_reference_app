import 'package:flutter/foundation.dart';

class CountryFilterState extends ChangeNotifier {
  int _pageSize = 500, _pageNo = 1;
  String? _name, _code;

  int get pageNo => _pageNo;
  int get pageSize => _pageSize;
  String? get name => _name;
  String? get code => _code;

  setPageSize(final int pageSize) {
    _pageSize = pageSize;
    notifyListeners();
  }

  resetPageSize() {
    _pageSize = 500;
    notifyListeners();
  }

  setPageNo(final int pageNo) {
    _pageNo = pageNo;
    notifyListeners();
  }

  resetPageNo() {
    _pageNo = 1;
    notifyListeners();
  }

  setName(final String name) {
    _name = name;
    notifyListeners();
  }

  resetName() {
    _name = null;
    notifyListeners();
  }

  setCode(final String code) {
    _code = code;
    notifyListeners();
  }

  resetCode() {
    _code = null;
    notifyListeners();
  }
}
