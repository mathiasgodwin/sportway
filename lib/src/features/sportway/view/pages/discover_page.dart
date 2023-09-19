import 'package:flutter/material.dart';

/// TODO: Finish the docs
/// DiscoverPage to...
class DiscoverPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'Discover';

  const DiscoverPage({super.key});

  /// Static method to return the widget as a PageRoute
  static Route go() =>
      MaterialPageRoute<void>(builder: (_) => const DiscoverPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: const Center(
        child: Text('This is DiscoverPage'),
      ),
    );
  }
}
