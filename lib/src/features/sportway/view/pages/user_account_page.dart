import 'package:flutter/material.dart';
import 'package:sportway/configs/styles.dart';

class UserAccountPage extends StatelessWidget {
  const UserAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return const Scaffold(
      body: Center(
        child: Text(
          "Account setting page",
        ),
      ),
    );
  }
}
