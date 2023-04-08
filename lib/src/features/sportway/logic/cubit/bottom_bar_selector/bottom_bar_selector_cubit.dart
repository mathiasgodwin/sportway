import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_bar_selector_state.dart';

class BottomBarSelectorCubit extends Cubit<BottomBarSelectorState> {
  BottomBarSelectorCubit() : super(const BottomBarSelectorState());

  void setBar(HomeBottomBar bottomBar) {
    emit(BottomBarSelectorState(bottomBars: bottomBar));
  }
}
