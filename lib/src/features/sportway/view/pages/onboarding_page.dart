import 'package:flutter/material.dart';

/// TODO: Finish the docs
/// OnboardingPage to...
class OnboardingPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'Onboarding';

  /// Static method to return the widget as a PageRoute
  static Route go() =>
      MaterialPageRoute<void>(builder: (_) => OnboardingPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is OnboardingPage'),
      ),
    );
  }
}
