import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/state/country_filter.state.dart';
import 'package:test_app/services/country.service.dart' as country_service;

class CountryFilter extends StatefulWidget {
  const CountryFilter({final Key? key}) : super(key: key);

  @override
  _CountryFilterState createState() => _CountryFilterState();
}

class _CountryFilterState extends State<CountryFilter> {
  var _submitButtonLoading = false;
  var _clearButtonLoading = false;
  final _nameController = TextEditingController();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future clearFilter() async {
    setState(() {
      _clearButtonLoading = true;
      _nameController.text = '';
    });
    context.read<CountryFilterState>().resetName();
    context.read<CountryFilterState>().resetCode();
    context.read<CountryFilterState>().resetPageNo();
    context.read<CountryFilterState>().resetPageSize();
    await country_service.index(context);
    Navigator.pop(context);
  }

  Future filter() async {
    setState(() {
      _submitButtonLoading = true;
    });
    await country_service.index(context);
    setState(() {
      _submitButtonLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      const SizedBox(height: 16),
    ];

    children.addAll([
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search_outlined),
            labelText: 'Name',
          ),
          maxLength: 128,
          onChanged: (newValue) {
            Provider.of<CountryFilterState>(context, listen: false)
                .setName(newValue);
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 0,
        ),
        child: SizedBox(
          width: double.infinity,
          child: TextButton(
            child: Text(
              _clearButtonLoading ? 'Loading...' : 'Clear Filter',
            ),
            onPressed: clearFilter,
          ),
        ),
      ),
      const Flexible(flex: 1, child: SizedBox(height: double.infinity)),
      Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 0,
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: Text(_submitButtonLoading ? 'Loading...' : 'Filter'),
            onPressed: filter,
          ),
        ),
      ),
      const SizedBox(height: 20),
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Filters'),
      ),
      body: SafeArea(
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
