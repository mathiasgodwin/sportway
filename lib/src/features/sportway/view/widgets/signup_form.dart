import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportway/configs/styles.dart';
import 'package:sportway/core/utils/ui_extensions/ui_extensions.dart';
import 'package:sportway/src/features/sportway/logic/cubit/signup/signup_cubit.dart';
import 'package:sportway/src/features/sportway/logic/cubit/update_profile_name/update_profile_name.dart';
import 'package:sportway/src/features/sportway/view/pages/pages.dart';
import 'package:sportway/src/features/sportway/view/widgets/widgets.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.status.isSubmissionInProgress) {
              context.showLoading();
            } else if (state.status.isSubmissionSuccess) {
            } else if (state.status.isSubmissionFailure) {
              context.showErrorMessage(state.errorMessage ?? 'Sign Up Failed');
            }
          },
        ),
        BlocListener<UpdateProfileNameCubit, UpdateProfileNameState>(
          listener: (context, state) {
            if (state.status.isSubmissionInProgress) {
              context.showLoading();
            } else if (state.status.isSubmissionSuccess) {
              Navigator.of(context, rootNavigator: true)
                ..pop()
                ..pop(true);
            } else if (state.status.isSubmissionFailure) {
              context.showErrorMessage(state.errorMessage ?? 'Sign Up Failed');
            }
          },
        ),
      ],
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Insets.lg + 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _SignUpMessage(),
                    const Gap(20),
                    Column(
                      children: [
                        _NameInput(),
                        const Gap(5),
                        _EmailInput(),
                        const Gap(5),
                        _PasswordInput(),
                      ],
                    ),
                    VSpace.s10,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const _SignUpButton(),
                        const Gap(10),
                        const Text('Or'),
                        const Gap(10),
                        _SigInMessage(),
                        const Gap(15),
                        _TermsMessage(),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 14 * 6),
              key: const Key('signUpForm_emailInput_textField'),
              onChanged: (email) =>
                  context.read<SignUpCubit>().emailChanged(email),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 14 * 6),
              key: const Key('signUpForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<SignUpCubit>().passwordChanged(password),
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

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              flex: 9,
              child: FilledButton(
                style: ElevatedButton.styleFrom(),
                onPressed: state.status.isValidated
                    ? () async {
                        await context.read<SignUpCubit>().signUpFormSubmitted();
                        // ignore: use_build_context_synchronously
                        await context
                            .read<UpdateProfileNameCubit>()
                            .updateProfileName();
                      }
                    : () {
                        context.read<SignUpCubit>().validateIsEmptyFields();
                        context
                            .read<UpdateProfileNameCubit>()
                            .validateIsEmptyField();
                      },
                child: const Text('Sign Up'),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileNameCubit, UpdateProfileNameState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 14 * 6),
              key: const Key('signUpForm_emailInput_textField'),
              onChanged: (fullname) => context
                  .read<UpdateProfileNameCubit>()
                  .fullNameChanged(fullname),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                // contentPadding: EdgeInsets.zero,
                labelText: 'Full Name',
                helperText: '',
                errorText: state.fullName.invalid ? state.fullName.error : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SignUpMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "Create Account",
            style: theme.textTheme.headlineLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Text(
            "Let's get to know you.",
          )
        ],
      ),
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
    Navigator.of(context).push(LoginPage.go());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
      text: TextSpan(
        recognizer: _tapGestureRecognizer,
        text: 'Sign in',
        style: theme.textTheme.bodySmall?.copyWith(color: Colors.blue),
      ),
    );
  }
}

class _SigInMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Already a user? ',
          style: TextStyle(fontSize: FontSizes.s14),
        ),
        _SignInLink(),
        Text(
          ' here',
          style: TextStyle(fontSize: FontSizes.s14),
        )
      ],
    );
  }
}

class _TermsMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const FittedBox(
            child: Text(
          'By creating an account, you agree to our',
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _TermsLink(),
            const FittedBox(
              child: Text(' and '),
            ),
            _PrivacyLink(),
            //
          ],
        ),
      ],
    );
  }
}

class _TermsLink extends StatefulWidget {
  @override
  State<_TermsLink> createState() => _TermsLinkState();
}

class _TermsLinkState extends State<_TermsLink> {
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

  void _handlePress() async {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
      text: TextSpan(
        recognizer: _tapGestureRecognizer,
        text: 'Terms of Service',
        style: theme.textTheme.bodySmall?.copyWith(color: Colors.blue),
      ),
    );
  }
}

class _PrivacyLink extends StatefulWidget {
  @override
  State<_PrivacyLink> createState() => _PrivacyLinkState();
}

class _PrivacyLinkState extends State<_PrivacyLink> {
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

  void _handlePress() async {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
      text: TextSpan(
        recognizer: _tapGestureRecognizer,
        text: 'Privacy Policy',
        style: theme.textTheme.bodySmall?.copyWith(color: Colors.blue),
      ),
    );
  }
}
