import 'package:flutter/material.dart';
import 'package:test_app/components/global/my_drawer.dart';

class CountryIndex extends StatefulWidget {
  const CountryIndex({Key? key}) : super(key: key);

  @override
  _CountryIndexState createState() => _CountryIndexState();
}

class _CountryIndexState extends State<CountryIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      extendBody: true,
      appBar: AppBar(
        title: const Text('Countries'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () => Navigator.pushNamed(context, 'country_filter'),
          )
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Welcome to country list page'),
        ),
      ),
    );
  }
}
