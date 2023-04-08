part of 'bottom_bar_selector_cubit.dart';

enum HomeBottomBar { discover, buddies, userAccount, settings }

class BottomBarSelectorState extends Equatable {
  const BottomBarSelectorState({
    this.bottomBars = HomeBottomBar.discover,
  });

  final HomeBottomBar bottomBars;
  @override
  List<Object> get props => [bottomBars];
}
