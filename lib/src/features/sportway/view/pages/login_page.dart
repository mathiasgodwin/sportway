import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_components/google_components.dart';
import 'package:sportway/src/features/sportway/logic/cubit/login/login_cubit.dart';

import '../widgets/login_form.dart';

/// TODO: Finish the docs
/// LoginPage to...
class LoginPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'Login';

  const LoginPage({Key? key}) : super(key: key);

  /// Static method to return the widget as a PageRoute
  static Route go() =>
      MaterialPageRoute<void>(builder: (_) => const LoginPage());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: Brightness.dark));
    //
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                LoginCubit(context.read<GoogleComponentsRepository>()),
          ),
        ],
        child: const LoginForm(),
      ),
    );
  }
}
