import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:test_app/components/global/my_drawer.dart';
import 'package:test_app/exceptions/validation.exception.dart';
import 'package:test_app/interfaces/auth/register.interface.dart';
import 'package:test_app/services/auth.service.dart' as auth_service;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _registerFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  var _autoValidateMode = AutovalidateMode.disabled;
  var _showPassword = false;
  var _showPasswordConfirmation = false;
  var _isLoading = false;
  FocusNode? _passwordFocus, _passwordConfirmationFocus, _emailFocus;
  Map _validationErrors = {};
  bool _termsAccepted = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _passwordConfirmationFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocus?.dispose();
    _emailFocus?.dispose();

    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  _register() async {
    try {
      if (!_termsAccepted) {
        return showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text('Terms are not accepted'),
            content: Text('Please accept terms and conditions to continue'),
          ),
        );
      }

      setState(() {
        _isLoading = true;
        _validationErrors = {};
      });

      if (!_registerFormKey.currentState!.validate()) {
        return setState(() {
          _isLoading = false;
          _autoValidateMode = AutovalidateMode.always;
        });
      }

      await auth_service.register(
        context,
        RegisterRequest(
          _nameController.text,
          _emailController.text,
          _passwordController.text,
          _passwordConfirmationController.text,
        ),
      );

      setState(() {
        _isLoading = false;
      });

      Navigator.pushNamed(context, 'dashboard');
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      extendBody: true,
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Form(
          autovalidateMode: _autoValidateMode,
          key: _registerFormKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              const SizedBox(height: 20.0),
              Hero(
                child: TextFormField(
                  autofillHints: const [AutofillHints.name],
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(_emailFocus);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter name';
                    }
                    if (_validationErrors.containsKey('email')) {
                      return _validationErrors['email'][0];
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Name *',
                  ),
                  maxLength: 128,
                ),
                tag: 'nameInput',
              ),
              const SizedBox(height: 20.0),
              Hero(
                child: TextFormField(
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
                  autofillHints: const [AutofillHints.newPassword],
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
                        icon: Icon(!_showPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
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
              const SizedBox(height: 10),
              TextFormField(
                obscureText: !_showPasswordConfirmation,
                controller: _passwordConfirmationController,
                focusNode: _passwordConfirmationFocus,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  }
                  if (_validationErrors.containsKey('passwordConfirmation')) {
                    return _validationErrors['passwordConfirmation'][0];
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                      icon: Icon(!_showPasswordConfirmation
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _showPasswordConfirmation =
                              !_showPasswordConfirmation;
                        });
                      }),
                  labelText: 'Password Confirmation *',
                ),
                maxLength: 64,
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                dense: true,
                contentPadding: const EdgeInsets.all(0),
                value: _termsAccepted,
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _termsAccepted = value;
                    });
                  }
                },
                title: const Text("I Agree to accept all terms and conditions"),
              ),
              Hero(
                child: ElevatedButton(
                  child: Text(_isLoading ? 'Loading...' : 'Register'),
                  onPressed: _isLoading ? null : _register,
                ),
                tag: 'cta',
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  const Flexible(
                    flex: 1,
                    child: SizedBox(width: double.infinity),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    child: const Text('Login instead?'),
                  ),
                ],
              ),
              const SizedBox(height: 20.0)
            ],
          ),
        ),
      ),
    );
  }
}