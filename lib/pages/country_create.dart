import 'package:flutter/material.dart';
import 'package:test_app/components/global/my_drawer.dart';

class CountryCreate extends StatefulWidget {
  const CountryCreate({Key? key}) : super(key: key);

  @override
  _CountryCreateState createState() => _CountryCreateState();
}

class _CountryCreateState extends State<CountryCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      extendBody: true,
      appBar: AppBar(
        title: const Text('Add new Country'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const SafeArea(
        child: Center(
          child: Text('add new country'),
        ),
      ),
    );
  }
}
