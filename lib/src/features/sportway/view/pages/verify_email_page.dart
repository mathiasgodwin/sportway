import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_components/google_components.dart';
import 'package:sportway/configs/styles.dart';
import 'package:sportway/src/features/sportway/logic/cubit/recover_password/recover_password_cubit.dart';
import 'package:sportway/src/features/sportway/view/pages/login_page.dart';
import 'package:sportway/src/features/sportway/view/widgets/widgets.dart';

/// TODO: Finish the docs
/// VerifyEmailPage to...
class VerifyEmailPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'VerifyEmail';

  final String email;
  const VerifyEmailPage({Key? key, required this.email}) : super(key: key);

  /// Static method to return the widget as a PageRoute
  static Route go(String email) => MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
            create: (context) => RecoverPasswordCubit(
                context.read<GoogleComponentsRepository>()),
            child: VerifyEmailPage(
              email: email,
            ),
          ));

  @override
  Widget build(BuildContext context) {
    // Quickly populate the email field with gotten value
    context.read<RecoverPasswordCubit>().emailChanged(email);

    return Scaffold(
      appBar: AppBar(leading: const ArrowBackAppBarButton()),
      body: BlocConsumer<RecoverPasswordCubit, RecoverPasswordState>(
        listener: (context, state) {
          if (state.status == FormzStatus.submissionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 30),
                  action: SnackBarAction(
                      label: 'Ok',
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      }),
                  content: const Text('Confirmation link sent!'),
                ),
              );
          } else if (state.status == FormzStatus.submissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content:
                      Text(state.errorMessage ?? 'Failed to verify email')));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: Insets.lg + 4),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const _EmailAvatar(),
                  const Gap(20),
                  _MessageWithEmail(email: email),
                  const Gap(20),
                  const _BackToLoginButton(),
                  const Gap(5),
                  _ResendEmailButton(),
                ]),
          );
        },
      ),
    );
  }
}

class _ResendEmailButton extends StatefulWidget {
  @override
  State<_ResendEmailButton> createState() => _ResendEmailButtonState();
}

class _ResendEmailButtonState extends State<_ResendEmailButton> {
  bool canResend = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoverPasswordCubit, RecoverPasswordState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    !canResend
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text('Resend after: '),
                                TimeCounter(
                                    seconds: 120,
                                    onComplete: () {
                                      setState(() {
                                        canResend = true;
                                      });
                                    })
                              ],
                            ),
                          )
                        : const SizedBox(),
                    TextButton(
                      onPressed: !canResend
                          ? null
                          : () async {
                              await context
                                  .read<RecoverPasswordCubit>()
                                  .recoverPassword();
                              setState(() {
                                canResend = false;
                              });
                            },
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColor,
                      ),
                      child: const Text(
                        'Resend Email',
                      ),
                    ),
                  ],
                );
        });
  }
}

class _BackToLoginButton extends StatelessWidget {
  const _BackToLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(LoginPage.go());
        },
        child: const Text('Back to Login'));
  }
}

class _MessageWithEmail extends StatelessWidget {
  final String email;
  const _MessageWithEmail({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('Verify your Email',
              style: theme.textTheme.headlineLarge?.copyWith(
                color: theme.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
        VSpace.s15,
        FittedBox(
          child: Text(
            'We\'ve sent a confirmation email to:',
            style: theme.textTheme.labelMedium?.copyWith(),
          ),
        ),
        Text(emailFormatted(email),
            style: theme.textTheme.labelMedium?.copyWith()),
        VSpace.s15,
        const FittedBox(child: Text('Check the email and click on the')),
        const Text('confirmation link to continue'),
      ],
    );
  }

  String emailFormatted(String email) {
    final a = email.split('@');
    final emailLength = a[0].length;
    final emailForm =
        a[0].replaceRange(emailLength ~/ 2, null, '*' * (emailLength ~/ 2));
    return '$emailForm@${a[1]}';
  }
}

class _EmailAvatar extends StatelessWidget {
  const _EmailAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300.0),
                    color: const Color.fromARGB(255, 221, 255, 247),
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: ClipRRect(
            child: Align(
              alignment: Alignment.center,
              widthFactor: .80,
              heightFactor: .80,
              child: Image.asset(
                'assets/images/verify-email.png',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
