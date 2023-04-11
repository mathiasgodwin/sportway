import 'package:flutter/material.dart';

/// TODO: Finish the docs
/// BuddiesPage to...
class BuddiesPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'Buddies';

  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(builder: (_) => BuddiesPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buddies'),
      ),
      body: Center(
        child: Text('This is BuddiesPage'),
      ),
    );
  }
}
