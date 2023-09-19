import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:sportway/configs/styles.dart';
import 'package:sportway/core/utils/ui_extensions/ui_extensions.dart';
import 'package:sportway/src/features/sportway/logic/cubit/change_password/change_password_cubit.dart';
import 'package:sportway/src/features/sportway/view/widgets/widgets.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionInProgress) {
          context.showLoading();
        } else if (state.status.isSubmissionSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          context.showSuccessMessage('Password updated successfully');
        } else if (state.status.isSubmissionFailure ||
            state.status.isSubmissionCanceled) {
          Navigator.of(context, rootNavigator: true).pop();
          context.showErrorMessage(state.errorMessage ?? 'Update failed');
        }
      },
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
                    const _ChangePasswordMessage(),
                    const Gap(20),
                    _PasswordInput(),
                    const Gap(10),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ChangePasswordButton(),
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

class _ChangePasswordButton extends StatelessWidget {
  const _ChangePasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
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
                        await context
                            .read<ChangePasswordCubit>()
                            .changePasswordFormSubmitted();
                      }
                    : () {
                        context
                            .read<ChangePasswordCubit>()
                            .validateIsEmptyFields();
                      },
                child: const Text('Submit'),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ChangePasswordMessage extends StatelessWidget {
  const _ChangePasswordMessage({Key? key}) : super(key: key);

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
            "Change Password",
            style: theme.textTheme.headlineLarge?.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Text(
            "Enter Old and New password to continue.",
          )
        ],
      ),
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
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 14 * 6),
              key: const Key('oldPasswordForm_passwordInput_textField'),
              onChanged: (password) => context
                  .read<ChangePasswordCubit>()
                  .oldPasswordChanged(password),
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
                errorText:
                    state.oldPassword.invalid ? state.oldPassword.error : null,
              ),
            ),
            TextFormField(
              scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 14 * 6),
              key: const Key('newPasswordForm_passwordInput_textField'),
              onChanged: (password) => context
                  .read<ChangePasswordCubit>()
                  .newPasswordChanged(password),
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
                labelText: 'New Password',
                helperText: '',
                errorText:
                    state.newPassword.invalid ? state.newPassword.error : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
