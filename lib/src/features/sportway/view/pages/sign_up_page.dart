import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_components/google_components.dart';
import 'package:sportway/src/features/sportway/logic/cubit/google_signin/google_signin_cubit.dart';
import 'package:sportway/src/features/sportway/logic/cubit/signup/signup_cubit.dart';
import 'package:sportway/src/features/sportway/logic/cubit/update_profile_name/update_profile_name.dart';
import 'package:sportway/src/features/sportway/view/widgets/signup_form.dart';

/// TODO: Finish the docs
/// SignUpPage to...
class SignUpPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'SignUp';

  const SignUpPage({Key? key}) : super(key: key);

  /// Static method to return the widget as a PageRoute
  static Route<bool> go() =>
      MaterialPageRoute<bool>(builder: (_) => const SignUpPage());

  @override
  Widget build(BuildContext context) {
    //
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    //
    return Scaffold(
        body: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SignUpCubit(context.read<GoogleComponentsRepository>()),
        ),
        BlocProvider(
          create: (context) => UpdateProfileNameCubit(
              context.read<GoogleComponentsRepository>()),
        ),
      ],
      child: const SignupForm(),
    ));
  }
}
