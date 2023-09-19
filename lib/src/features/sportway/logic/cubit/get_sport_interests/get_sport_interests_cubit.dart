import 'package:bloc/bloc.dart';
import 'package:cloud_storage/cloud_storage.dart';
import 'package:cloud_storage/dto/interest_dto.dart';
import 'package:equatable/equatable.dart';

part 'get_sport_interests_state.dart';

class GetSportInterestsCubit extends Cubit<GetSportInterestsState> {
  final ICloudStorage repository;
  GetSportInterestsCubit(this.repository)
      : super(const GetSportInterestsState());

  Future<void> getSportInterests() async {
    try {
      emit(state.copyWith(status: GetSportInterestsStatus.loading));
      final data = await repository.getInterests();
      emit(state.copyWith(
        status: GetSportInterestsStatus.success,
        data: data,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GetSportInterestsStatus.failure,
        errorMessage: 'There was error retrieving sport interests',
      ));
    }
  }
}
