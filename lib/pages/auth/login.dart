import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:test_app/components/global/my_drawer.dart';
import 'package:test_app/exceptions/validation.exception.dart';
import 'package:test_app/interfaces/auth/login.interface.dart';
import 'package:test_app/services/auth.service.dart' as auth_service;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _autoValidateMode = AutovalidateMode.disabled;
  var _isLoading = false;
  var _showPassword = false;
  Map _validationErrors = {};

  final _loginFormKey = GlobalKey<FormState>();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  FocusNode? _passwordFocus;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _passwordFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (_passwordFocus != null) _passwordFocus!.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _login() async {
    try {
      if (!_loginFormKey.currentState!.validate()) {
        return setState(() {
          _isLoading = false;
          _autoValidateMode = AutovalidateMode.always;
        });
      }

      setState(() {
        _isLoading = true;
        _validationErrors = {};
      });
      await auth_service.login(
        context,
        LoginRequest(_emailController.text, _passwordController.text),
      );
      Navigator.pushReplacementNamed(context, 'dashboard');
    } on ValidationException catch (e) {
      setState(() {
        _validationErrors = e.errors;
        _isLoading = false;
        _autoValidateMode = AutovalidateMode.always;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Login failed'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      extendBody: true,
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Form(
          autovalidateMode: _autoValidateMode,
          key: _loginFormKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              const SizedBox(height: 20.0),
              Hero(
                child: TextFormField(
                  key: const Key('emailInput'),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(_passwordFocus);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    }
                    if (!isEmail(value)) {
                      return 'Please enter valid email';
                    }
                    if (_validationErrors.containsKey('email')) {
                      return _validationErrors['email'][0];
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email *',
                  ),
                  maxLength: 128,
                ),
                tag: 'emailInput',
              ),
              const SizedBox(height: 20.0),
              Hero(
                child: TextFormField(
                  key: const Key('passwordInput'),
                  autofillHints: const [AutofillHints.password],
                  obscureText: !_showPassword,
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    if (_validationErrors.containsKey('password')) {
                      return _validationErrors['password'][0];
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                        icon: Icon(_showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        }),
                    labelText: 'Password *',
                  ),
                  maxLength: 64,
                ),
                tag: 'passwordInput',
              ),
              const SizedBox(height: 20.0),
              Hero(
                child: ElevatedButton(
                    key: const Key('loginButton'),
                    child: Text(
                      _isLoading ? 'Loading...' : 'Login',
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: _isLoading ? null : _login),
                tag: 'cta',
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  TextButton(
                    key: const Key('forgotPasswordButton'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'forgot_password');
                    },
                    child: const Text('Forgot password?'),
                  ),
                  const Flexible(
                      flex: 1, child: SizedBox(width: double.infinity)),
                  TextButton(
                    key: const Key('registerButton'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'register');
                    },
                    child: const Text('Register instead?'),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}