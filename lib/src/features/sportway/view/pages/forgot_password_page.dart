import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_components/google_components.dart';
import 'package:sportway/src/features/sportway/logic/cubit/recover_password/recover_password_cubit.dart';
import 'package:sportway/src/features/sportway/view/widgets/widgets.dart';

/// TODO: Finish the docs
/// ForgotPasswordPage to...
class ForgotPasswordPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'ForgotPassword';

  const ForgotPasswordPage({Key? key}) : super(key: key);

  /// Static method to return the widget as a PageRoute
  static Route go() =>
      MaterialPageRoute<void>(builder: (_) => const ForgotPasswordPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const ArrowBackAppBarButton(),
        ),
        body: BlocProvider(
          create: (context) =>
              RecoverPasswordCubit(context.read<GoogleComponentsRepository>()),
          child: const ForgotPasswordForm(),
        ));
  }
}
