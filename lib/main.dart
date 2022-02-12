import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/pages/homepage.dart';
import 'package:test_app/pages/dashboard.dart';
import 'package:test_app/state/auth.state.dart';
import 'package:test_app/pages/auth/login.dart';
import 'package:test_app/pages/auth/register.dart';
import 'package:test_app/pages/country_index.dart';
import 'package:test_app/pages/country_create.dart';
import 'package:test_app/pages/country_filter.dart';
import 'package:test_app/state/country_show.state.dart';
import 'package:test_app/state/country_index.state.dart';
import 'package:test_app/state/country_filter.state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthState()),
        ChangeNotifierProvider(create: (_) => CountryIndexState()),
        ChangeNotifierProvider(create: (_) => CountryShowState()),
        ChangeNotifierProvider(create: (_) => CountryFilterState()),
      ],
      child: MaterialApp(
        theme: ThemeData.light(), // Provide light theme
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'Test App',
        home: const HomePage(title: 'Home Page'),
        routes: {
          'homepage': (context) => const HomePage(title: 'Home Page'),
          'login': (context) => const Login(),
          'register': (context) => const Register(),
          'dashboard': (context) => const Dashboard(),
          'country_index': (context) => const CountryIndex(),
          'country_create': (context) => const CountryCreate(),
          'country_filter': (context) => const CountryFilter(),
        },
      ),
    );
  }
}
