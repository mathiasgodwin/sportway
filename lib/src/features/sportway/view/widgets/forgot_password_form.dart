import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:sportway/configs/styles.dart';
import 'package:sportway/src/features/sportway/logic/cubit/recover_password/recover_password_cubit.dart';
import 'package:sportway/src/features/sportway/view/pages/verify_email_page.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecoverPasswordCubit, RecoverPasswordState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          // Typically pass this to another page with obscurity.

          Navigator.of(context)
              .pushReplacement(VerifyEmailPage.go(state.email.value));
        } else if (state.status == FormzStatus.submissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text(state.errorMessage ?? 'Failed to verify email')));
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Insets.lg + 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: Insets.xxl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ForgotPasswordMessage(),
                    VSpace.s60,
                    _EmailInput(),
                    Flexible(child: _SubmitButton()),
                    VSpace.s15,
                    _SignInLink(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ForgotPasswordMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Forgot Password",
          style: theme.textTheme.headlineLarge?.copyWith(
            color: theme.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        VSpace.s10,
        Padding(
          padding: EdgeInsets.all(Insets.med),
          child: const Column(
            children: <Widget>[
              Text(
                "Enter the email address you used to create your account and we will email you a link to reset your password",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoverPasswordCubit, RecoverPasswordState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const Center(child: CircularProgressIndicator())
              : FilledButton(
                  onPressed: state.status.isValidated
                      ? () =>
                          context.read<RecoverPasswordCubit>().recoverPassword()
                      : () {
                          context
                              .read<RecoverPasswordCubit>()
                              .validateIsEmtptyField();
                        },
                  style: ElevatedButton.styleFrom(),
                  child: const Text('Submit'),
                );
        });
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoverPasswordCubit, RecoverPasswordState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              key: const Key('loginForm_emailInput_textField'),
              onChanged: (email) =>
                  context.read<RecoverPasswordCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                labelText: 'Email Address',
                helperText: '',
                errorText: state.email.invalid ? state.email.error : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SignInLink extends StatefulWidget {
  @override
  State<_SignInLink> createState() => _SignInLinkState();
}

class _SignInLinkState extends State<_SignInLink> {
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = _handlePress;
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  void _handlePress() async {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
              recognizer: _tapGestureRecognizer,
              text: 'Back to Login,',
              style: const TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}
