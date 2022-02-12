import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/state/auth.state.dart';
import 'package:test_app/services/auth.service.dart' as auth_service;

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(context) {
    return Consumer<AuthState>(
      builder: (context, state, _) {
        // This list will contain items that will be display on sidebar
        List<Widget> list;
        final currentRoute = ModalRoute.of(context)!.settings.name;

        // Show loading as long as prefs are loading
        if (state.token != null) {
          list = [
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              selected: currentRoute == 'dashboard',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'dashboard');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Countries'),
              selected: currentRoute == 'country_index',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'country_index');
              },
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Add New Country'),
              selected: currentRoute == 'country_create',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'country_create');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.delete_forever),
              title: const Text('Logout'),
              onTap: () async {
                await auth_service.logout(context);
                Navigator.pop(context);
                Navigator.of(context).pushNamedAndRemoveUntil(
                  'login',
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ];
        } else {
          list = [
            ListTile(
              leading: const Icon(Icons.lock),
              selected: currentRoute == '/' || currentRoute == 'login',
              title: const Text('Login'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'login');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              selected: currentRoute == 'register',
              title: const Text('Register'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'register');
              },
            ),
          ];
        }

        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              if (state.token != null && state.user != null)
                UserAccountsDrawerHeader(
                  currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  accountName: Text(state.user?.name ?? ""),
                  accountEmail: Text(state.user?.email ?? ""),
                )
              else
                DrawerHeader(
                  child: const Text(
                    'Test App',
                    style: TextStyle(color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ...list,
            ],
          ),
        );
      },
    );
  }
}
