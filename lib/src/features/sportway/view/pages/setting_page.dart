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
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                dense: true,
                onTap: () {
                  Navigator.of(context).push(
                    ChangePasswordPage.go(),
                  );
                },
                subtitle: const Text('Change password'),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  Navigator.of(context).push(
                    ChangeDetailsPage.go(),
                  );
                },
                subtitle: const Text('Update Profile'),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              )
            ],
          ),
        ),
      ),
    );
  }
}
