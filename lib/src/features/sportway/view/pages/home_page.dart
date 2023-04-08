import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportway/src/features/sportway/logic/cubit/get_sport_interests/get_sport_interests_cubit.dart';

/// TODO: Finish the docs
/// HomePage to...
class HomePage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'Home';

  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(builder: (_) => HomePage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is HomePage'),
      ),
    );
  }
}
