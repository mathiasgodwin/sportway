import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:sportway/configs/styles.dart';
import 'package:sportway/core/utils/ui_extensions/ui_extensions.dart';
import 'package:sportway/src/features/sportway/logic/bloc/auth/auth_bloc.dart';
import 'package:sportway/src/features/sportway/logic/cubit/login/login.dart';
import 'package:sportway/src/features/sportway/view/pages/pages.dart';
import 'package:sportway/src/features/sportway/view/widgets/widgets.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(listener: (context, state) {
      if (state.status.isSubmissionInProgress) {
        context.showLoading();
      } else if (state.status.isSubmissionFailure) {
        Navigator.of(context, rootNavigator: true).pop();
        context
            .showErrorMessage(state.exceptionError ?? 'Authentication Failure');
      } else if (state.status.isSubmissionSuccess) {
        context.read<AuthBloc>().add(AppAuthRequested());
      }
    }, child: LayoutBuilder(builder: (context, constraints) {
      return ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: Insets.lg + 8),
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LoginMessage(),
                VSpace.s35,
                _EmailInput(),
                const Gap(5),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _PasswordInput(),
                    ),
                  ],
                ),
                const Gap(10),
                _ForgotPasswordLink(),
                const Gap(15),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const _LoginButton(),
                    VSpace.s10,
                    const Text('Or'),
                    VSpace.s10,
                    _SignUpMessage(),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }));
  }
}

class _LoginMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Welcome back",
              style: theme.textTheme.headlineLarge?.copyWith(
                color: theme.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              )),
          const Text(
            "It's nice having you visit again.",
          )
        ],
      ),
    );
  }
}

class _SignUpMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'New user? ',
          style: TextStyle(fontSize: FontSizes.s14),
        ),
        _SignUpLink(),
        Text(
          ' here',
          style: TextStyle(fontSize: FontSizes.s14),
        )
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              key: const Key('loginForm_emailInput_textField'),
              onChanged: (email) =>
                  context.read<LoginCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                // contentPadding: EdgeInsets.zero,
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

class _PasswordInput extends StatefulWidget {
  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool _isObscureText = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<LoginCubit>().passwordChanged(password),
              obscureText: _isObscureText,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscureText = !_isObscureText;
                      });
                    },
                    icon: Icon(_isObscureText
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded)),
                filled: true,
                isDense: true,
                labelText: 'Password',
                helperText: '',
                errorText: state.password.invalid ? state.password.error : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SignUpLink extends StatefulWidget {
  @override
  State<_SignUpLink> createState() => _SignUpLinkState();
}

class _SignUpLinkState extends State<_SignUpLink> {
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
    final isSignedUp =
        await Navigator.of(context).push<bool>(SignUpPage.go()) ?? false;
    // GoRouter.of(context).push(AppRouter.createAccount);

    if (isSignedUp) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
              content: Text('Log-in with registered credentials now!')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
      text: TextSpan(
        recognizer: _tapGestureRecognizer,
        text: 'Sign up',
        style: theme.textTheme.bodySmall?.copyWith(color: Colors.blue),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                flex: 9,
                child: FilledButton(
                  onPressed: state.status.isValidated
                      ? () => context.read<LoginCubit>().loginWithCredential()
                      : () {
                          context.read<LoginCubit>().validateIsEmptyFields();
                        },
                  style: ElevatedButton.styleFrom(),
                  child: const Text('Login'),
                ),
              ),
            ],
          );
        });
  }
}

class _ForgotPasswordLink extends StatefulWidget {
  @override
  State<_ForgotPasswordLink> createState() => _ForgotPasswordLinkState();
}

class _ForgotPasswordLinkState extends State<_ForgotPasswordLink> {
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

  void _handlePress() {
    Navigator.of(context).push<void>(ForgotPasswordPage.go());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
      text: TextSpan(
        recognizer: _tapGestureRecognizer,
        text: 'Forgot Password?',
        style: theme.textTheme.bodySmall?.copyWith(color: Colors.blue),
      ),
    );
  }
}
