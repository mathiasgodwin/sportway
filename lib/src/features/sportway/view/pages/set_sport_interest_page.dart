import 'package:app_preference/app_preference.dart';
import 'package:cloud_storage/cloud_storage.dart';
import 'package:cloud_storage/dto/interest_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportway/configs/styles.dart';
import 'package:sportway/core/utils/constants/constants.dart';
import 'package:sportway/core/utils/ui_extensions/ui_extensions.dart';
import 'package:sportway/src/features/sportway/logic/cubit/get_sport_interests/get_sport_interests_cubit.dart';
import 'package:sportway/src/features/sportway/logic/cubit/save_sport_interest/save_sport_interest_cubit.dart';
import 'package:sportway/src/features/sportway/view/pages/home_page.dart';
import 'package:sportway/src/features/sportway/view/widgets/widgets.dart';

/// TODO: Finish the docs
/// SportInterestPage to...
class SportInterestPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'SportInterest';

  const SportInterestPage({super.key});

  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
          create: (context) =>
              SaveSportInterestCubit(context.read<CloudStorage>()),
          child: const SportInterestPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BlocListener<SaveSportInterestCubit, SaveSportInterestState>(
        listener: (context, state) async {
          if (state.status == SaveSportInterestStatus.loading) {
            context.showLoading();
          } else if (state.status == SaveSportInterestStatus.success) {
            context
                .read<AppPreference>()
                .setBool(key: 'hasInterest', value: true);
            await context.read<GetSportInterestsCubit>().getSportInterests();
            await Navigator.of(context)
                .pushAndRemoveUntil(HomePage.go(), (route) => false);
          }
        },
        child: Scaffold(
          appBar: AppBar(),
          bottomNavigationBar: const Padding(
            padding: EdgeInsets.all(8.0),
            child: _ContinueButton(),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.lg),
            child: const SingleChildScrollView(
              child: Column(
                children: [
                  InterestQuestionText(),
                  Gap(10),
                  OverlineText(),
                  Gap(10),
                  InterestChips(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    final canContinue = context.select<SaveSportInterestCubit, bool>(
        (SaveSportInterestCubit cubit) => cubit.state.interestList.isNotEmpty);
    return FilledButton(
      onPressed: canContinue
          ? () {
              context.read<SaveSportInterestCubit>().saveSportInterest();
            }
          : null,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Continue'),
          Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}

class InterestQuestionText extends StatelessWidget {
  const InterestQuestionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      'What are you interests?',
      style: theme.textTheme.headlineLarge,
    );
  }
}

class OverlineText extends StatelessWidget {
  const OverlineText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      'Select the area of sport that matches your interest',
      style: theme.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w300,
      ),
    );
  }
}

class InterestChips extends StatefulWidget {
  const InterestChips({Key? key}) : super(key: key);

  @override
  State<InterestChips> createState() => _InterestChipsState();
}

class _InterestChipsState extends State<InterestChips> {
  List<bool> selectionList = List.generate(
    AppConstants.sportInterest.length,
    (index) => false,
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: [
        for (int item = 0; item < AppConstants.sportInterest.length; item++)
          ChoiceChip(
            selected: selectionList[item],
            onSelected: (value) {
              //TODO: the procesing here needs optimization
              final name = AppConstants.sportInterest[item];
              final id = AppConstants.sportInterest.indexOf(name).toString();
              context
                  .read<SaveSportInterestCubit>()
                  .updateInterest(SportInterest(
                    name: name,
                    id: id,
                  ));
              setState(() {
                selectionList[item] = value;
              });
            },
            label: Text(AppConstants.sportInterest[item]),
          )
      ],
    );
  }
}
