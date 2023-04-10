import 'package:flutter/material.dart';
import 'package:sportway/src/features/sportway/view/pages/pages.dart';

/// TODO: Finish the docs
/// SettingsPage to...
class SettingsPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'Settings';

  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(builder: (_) => SettingsPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onPressed,
      subtitle: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
