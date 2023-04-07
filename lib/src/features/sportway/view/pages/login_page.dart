import 'package:flutter/material.dart';

/// TODO: Finish the docs
/// LoginPage to...
class LoginPage extends StatelessWidget {

/// Static named route for page
static const String route = 'Login';

/// Static method to return the widget as a PageRoute
static Route go() => MaterialPageRoute<void>(builder: (_) => LoginPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is LoginPage'),
     ),
   );
  }
}