import 'package:bloc/bloc.dart';
import 'package:cloud_storage/cloud_storage.dart';
import 'package:cloud_storage/dto/interest_dto.dart';
// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

part 'save_sport_interest_state.dart';

class SaveSportInterestCubit extends Cubit<SaveSportInterestState> {
  final ICloudStorage repository;
  SaveSportInterestCubit(this.repository)
      : super(const SaveSportInterestState());

  Future<void> saveSportInterest() async {
    try {
      emit(state.copyWith(status: SaveSportInterestStatus.loading));
      for (var interest in state.interestList) {
        await repository.saveInterest(interest);
      }
      emit(state.copyWith(
        status: SaveSportInterestStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SaveSportInterestStatus.failure,
        errorMessage: 'There was error saving sport interest',
      ));
    }
  }

  void updateInterest(SportInterest interest) {
    final interestList = List<SportInterest>.from(state.interestList);
    if (state.interestList.contains(interest)) {
      interestList.remove(interest);
      emit(state.copyWith(interestList: interestList));
    } else {
      interestList.add(interest);
      emit(state.copyWith(interestList: interestList));
    }
  }
}
