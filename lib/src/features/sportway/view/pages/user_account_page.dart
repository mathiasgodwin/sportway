import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportway/configs/styles.dart';
import 'package:sportway/src/features/sportway/logic/bloc/auth/auth_bloc.dart';
import 'package:sportway/src/features/sportway/logic/cubit/get_sport_interests/get_sport_interests_cubit.dart';

class UserAccountPage extends StatelessWidget {
  const UserAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const ProfilePicture(),
                const _KYCDetails(),
                VSpace.s20,
                const _InterestHeadingText(),
                const _InterestList(),
              ],
            ),
          ),
        ));
  }
}

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  String? name;

  @override
  void initState() {
    super.initState();
    name = context.read<AuthBloc>().state.user.name;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CircleAvatar(
      minRadius: 40,
      maxRadius: 60,
      backgroundColor: theme.colorScheme.secondary,
      child: Text(
        nameAsAvatar(),
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSecondary,
        ),
      ),
    );
  }

  String nameAsAvatar() {
    String userInitial;
    final fullNameSplit = name!.trim().split(' ');
    if (fullNameSplit.isNotEmpty && fullNameSplit.length >= 2) {
      userInitial =
          fullNameSplit[0][0].toUpperCase() + fullNameSplit[1][0].toUpperCase();
    } else {
      userInitial = name![0].toUpperCase();
    }
    return userInitial;
  }
}

class _KYCDetails extends StatelessWidget {
  const _KYCDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthBloc>().state.user;
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          user.name!,
          style: theme.textTheme.titleLarge,
        ),
        Text(
          user.email!,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

class _InterestList extends StatelessWidget {
  const _InterestList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSportInterestsCubit, GetSportInterestsState>(
      builder: (context, state) {
        if (state.status == GetSportInterestsStatus.loading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state.status == GetSportInterestsStatus.failure) {
          return IconButton(
              onPressed: () {
                context.read<GetSportInterestsCubit>().getSportInterests();
              },
              icon: const Icon(
                Icons.refresh_outlined,
              ));
        } else if (state.status == GetSportInterestsStatus.success) {
          return Wrap(
            spacing: 10.0,
            runSpacing: 4.0,
            children: [
              for (int item = 0; item < state.data!.length; item++)
                ChoiceChip(
                  selected: false,
                  onSelected: (value) {},
                  label: Text(state.data![item].name),
                )
            ],
          );
        }
        return Container();
      },
    );
  }
}

class _InterestHeadingText extends StatelessWidget {
  const _InterestHeadingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      'Your sport interest.',
      style: theme.textTheme.headlineLarge?.copyWith(
        color: theme.primaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
