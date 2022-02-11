import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/pages/homepage.dart';
import 'package:test_app/pages/dashboard.dart';
import 'package:test_app/state/auth.state.dart';
import 'package:test_app/pages/auth/login.dart';
import 'package:test_app/pages/auth/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthState())],
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
        },
      ),
    );
  }
}