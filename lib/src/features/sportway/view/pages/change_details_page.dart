import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_components/google_components.dart';
import 'package:sportway/configs/styles.dart';
import 'package:sportway/core/utils/ui_extensions/ui_extensions.dart';
import 'package:sportway/src/features/sportway/logic/bloc/auth/auth_bloc.dart';
import 'package:sportway/src/features/sportway/logic/cubit/batch_profile_update/batch_profile_update_cubit.dart';
import 'package:sportway/src/features/sportway/view/widgets/widgets.dart';

/// TODO: Finish the docs
/// ChangeDetailsPage to...
class ChangeDetailsPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'ChangeDetails';

  const ChangeDetailsPage({super.key});

  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
            create: (context) => BatchProfileUpdateCubit(
              context.read<GoogleComponentsRepository>(),
            ),
            child: const ChangeDetailsPage(),
          ));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<BatchProfileUpdateCubit, BatchProfileUpdateState>(
      listener: (context, state) {
        if (state.status.isSubmissionInProgress) {
          context.showLoading();
        } else if (state.status.isSubmissionFailure ||
            state.status.isSubmissionCanceled) {
          Navigator.of(context, rootNavigator: true).pop();
          context.showErrorMessage(state.errorMessage ?? 'Update failed');
        } else if (state.status.isSubmissionSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          context.read<AuthBloc>().add(AppUserUpdated());
          context.showSuccessMessage('Profile update successful');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const ArrowBackAppBarButton(),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Insets.lg + 8),
          child: Center(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  Text(
                    'Edit Profile',
                    style: theme.textTheme.headlineMedium,
                  ),
                  VSpace.s30,
                  const _UpdateProfileForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UpdateProfileForm extends StatefulWidget {
  const _UpdateProfileForm({Key? key}) : super(key: key);

  @override
  State<_UpdateProfileForm> createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<_UpdateProfileForm> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = context.watch<AuthBloc>().state.user;
    return BlocBuilder<BatchProfileUpdateCubit, BatchProfileUpdateState>(
      builder: (context, state) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Full name:',
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              TextFormField(
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 14 * 6),
                key: const Key('signUpForm_emailInput_textField'),
                onChanged: (fullname) => context
                    .read<BatchProfileUpdateCubit>()
                    .fullNameChanged(fullname),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "Full name",
                  isDense: true,
                  filled: true,
                  // contentPadding: EdgeInsets.zero,
                  labelText: user.name,
                  helperText: '',
                  errorText:
                      state.fullName.invalid ? state.fullName.error : null,
                ),
              ),
              VSpace.s5,
              Row(
                children: [
                  Text(
                    'Email Address:',
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              TextFormField(
                key: const Key('loginForm_emailInput_textField'),
                onChanged: (email) =>
                    context.read<BatchProfileUpdateCubit>().emailChanged(email),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  enabled: false,
                  isDense: true,
                  hintText: 'Email Address',
                  filled: true,
                  // contentPadding: EdgeInsets.zero,
                  labelText: user.email,
                  helperText: '',
                  errorText: state.email.invalid ? state.email.error : null,
                ),
              ),
              const Gap(10),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _UpdateProfileButton(),
                ],
              ),
            ]);
      },
    );
  }
}

class _UpdateProfileButton extends StatelessWidget {
  const _UpdateProfileButton({Key? key}) : super(key: key);

  final canUpdate = true;
  @override
  Widget build(BuildContext context) {
    List<bool> canUpdateList = [];

    final profileFormState =
        context.select((BatchProfileUpdateCubit cubit) => cubit.state);
    final fullName = profileFormState.fullName;

    canUpdateList.addAll([
      fullName.valid && fullName.error == null,
    ]);
    return FilledButton(
        onPressed: profileFormState.status.isValidated
            ? () async {
                await context
                    .read<BatchProfileUpdateCubit>()
                    .batchProfileUpdate();
              }
            : null,
        child: const Text('Update'));
  }
}
