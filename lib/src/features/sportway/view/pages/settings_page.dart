import 'package:flutter/material.dart';

/// TODO: Finish the docs
/// SettingsPage to...
class SettingsPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'Settings';

  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(builder: (_) => SettingsPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is SettingsPage'),
      ),
    );
  }
}
