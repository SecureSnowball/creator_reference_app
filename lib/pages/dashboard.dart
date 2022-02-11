import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Welcome to dashboard'),
        ),
      ),
    );
  }
}