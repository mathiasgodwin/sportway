import 'package:flutter/material.dart';

/// TODO: Finish the docs
/// SplashPage to...
class SplashPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'Splash';

  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(builder: (_) => SplashPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
