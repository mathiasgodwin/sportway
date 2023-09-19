import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_components/google_components.dart';
import 'package:sportway/src/features/sportway/logic/cubit/change_password/change_password_cubit.dart';
import 'package:sportway/src/features/sportway/view/widgets/widgets.dart';

/// TODO: Finish the docs
/// ChangePasswordPage to...
class ChangePasswordPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'ChangePassword';

  const ChangePasswordPage({super.key});

  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
            create: (context) => ChangePasswordCubit(
              context.read<GoogleComponentsRepository>(),
            ),
            child: const ChangePasswordPage(),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBackAppBarButton(),
      ),
      body: const ChangePasswordForm(),
    );
  }
}
