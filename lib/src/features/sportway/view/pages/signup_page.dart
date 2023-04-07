import 'package:flutter/material.dart';

/// TODO: Finish the docs
/// SignUpPage to...
class SignUpPage extends StatelessWidget {

/// Static named route for page
static const String route = 'SignUp';

/// Static method to return the widget as a PageRoute
static Route go() => MaterialPageRoute<void>(builder: (_) => SignUpPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is SignUpPage'),
     ),
   );
  }
}