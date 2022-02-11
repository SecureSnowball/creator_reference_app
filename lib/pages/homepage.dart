import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/state/auth.state.dart';
import 'package:test_app/components/global/my_drawer.dart';
import 'package:test_app/services/auth.service.dart' as auth_service;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder(
        future: auth_service.bootstrap(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return const HomePageBody();
        },
      ),
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthState>();
    final List<Widget> children = [
      const Text(
        "Welcome, Let's get started",
        style: TextStyle(
          fontSize: 20.0,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 16),
    ];
    if (authState.token != null) {
      children.add(
        ElevatedButton(
          key: const Key('dashboardButton'),
          child: const Text('Dashboard'),
          onPressed: () {
            Navigator.pushNamed(context, 'dashboard');
          },
        ),
      );
    } else {
      children.addAll([
        ElevatedButton(
          key: const Key('loginButton'),
          child: const Text('Login'),
          onPressed: () {
            Navigator.pushNamed(context, 'login');
          },
        ),
        ElevatedButton(
          key: const Key('registerButton'),
          child: const Text('Register'),
          onPressed: () {
            Navigator.pushNamed(context, 'register');
          },
        ),
      ]);
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}