import 'package:flutter/material.dart';

/// TODO: Finish the docs
/// SportInterestPage to...
class SportInterestPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'SportInterest';

  /// Static method to return the widget as a PageRoute
  static Route go() =>
      MaterialPageRoute<void>(builder: (_) => SportInterestPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is SportInterestPage'),
      ),
    );
  }
}
