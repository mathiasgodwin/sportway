import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportway/core/utils/ui_extensions/ui_extensions.dart';
import 'package:sportway/src/features/sportway/logic/bloc/auth/auth_bloc.dart';
import 'package:sportway/src/features/sportway/logic/cubit/signout/sign_out_cubit.dart';
import 'package:sportway/src/features/sportway/view/pages/pages.dart';
import 'package:sportway/src/features/sportway/view/widgets/widgets.dart';

/// TODO: Finish the docs
/// SettingsPage to...
class SettingsPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'Settings';

  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(builder: (_) => SettingsPage());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<SignOutCubit, SignOutState>(
      listener: (context, state) {
        if (state.status == SignOutStatus.loading) {
          context.showLoading();
        } else if (state.status == SignOutStatus.failure) {
          Navigator.of(context, rootNavigator: true).pop();
        } else if (state.status == SignOutStatus.success) {
          context.read<AuthBloc>().add(AppAuthRequested());
          // Navigator.of(context)
          //     .pushAndRemoveUntil(LoginPage.go(), (route) => false);
        }
      },
      child: Scaffold(
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
                  title: Text(
                    'Change password',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    Navigator.of(context).push(
                      ChangeDetailsPage.go(),
                    );
                  },
                  title: Text(
                    'Update Profile',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                ListTile(
                  onTap: () {
                    context.read<SignOutCubit>().signOut();
                  },
                  title: const SignOutButton(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<SignOutCubit, SignOutState>(
      builder: (context, state) {
        return Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Logout',
              style: theme.textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.normal),
            ),
            const Gap(5),
            Icon(
              Icons.logout,
              color: theme.colorScheme.secondary,
            )
          ],
        );
      },
    );
  }
}
