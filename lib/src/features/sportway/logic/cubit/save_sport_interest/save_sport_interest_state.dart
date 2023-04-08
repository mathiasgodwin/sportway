part of 'save_sport_interest_cubit.dart';

enum SaveSportInterestStatus { initial, loading, success, failure }

class SaveSportInterestState extends Equatable {
  const SaveSportInterestState({
    this.interestList = const [],
    this.status = SaveSportInterestStatus.initial,
    this.errorMessage,
  });

  final String? errorMessage;
  final List<SportInterest> interestList;
  final SaveSportInterestStatus status;

  SaveSportInterestState copyWith({
    List<SportInterest>? interestList,
    String? errorMessage,
    SaveSportInterestStatus? status,
  }) {
    return SaveSportInterestState(
        interestList: interestList ?? this.interestList,
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        errorMessage,
        status,
        interestList,
      ];
}
