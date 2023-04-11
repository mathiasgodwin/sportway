import 'package:app_preference/app_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportway/configs/styles.dart';
import 'package:sportway/src/features/sportway/view/pages/pages.dart';
import 'package:sportway/src/features/sportway/view/widgets/widgets.dart';

/// TODO: Finish the docs
/// OnboardingPage to...
class OnboardingPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'Onboarding';

  const OnboardingPage({super.key});

  /// Static method to return the widget as a PageRoute
  static Route go() =>
      MaterialPageRoute<void>(builder: (_) => const OnboardingPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const OnboardImage(),
                const AppNameText(),
                const Text('You are about to get connected'),
                VSpace.s40,
                const AuthButtonsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppNameText extends StatelessWidget {
  const AppNameText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      'Sport Way.',
      style: theme.textTheme.headlineLarge?.copyWith(
        color: theme.primaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AuthButtonsList extends StatelessWidget {
  const AuthButtonsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SignUpButton(),
        VSpace.s10,
        const LoginButton(),
      ],
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        RepositoryProvider.of<AppPreference>(context).setFirstLaunch;
        Navigator.of(context).pushAndRemoveUntil(
          SignUpPage.go(),
          (route) => false,
        );
      },
      child: const Text('Sign Up'),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: () {
        RepositoryProvider.of<AppPreference>(context).setFirstLaunch;
        Navigator.of(context).pushAndRemoveUntil(
          LoginPage.go(),
          (route) => false,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Login',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.primaryColor,
            ),
          ),
          Icon(
            Icons.arrow_forward,
            color: theme.primaryColor,
          ),
        ],
      ),
    );
  }
}
