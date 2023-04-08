part of 'get_sport_interests_cubit.dart';

enum GetSportInterestsStatus { initial, loading, success, failure }

class GetSportInterestsState extends Equatable {
  const GetSportInterestsState({
    this.status = GetSportInterestsStatus.initial,
    this.errorMessage,
    this.data,
  });

  final String? errorMessage;
  final GetSportInterestsStatus status;
  final List<SportInterest>? data;

  GetSportInterestsState copyWith({
    String? errorMessage,
    GetSportInterestsStatus? status,
    List<SportInterest>? data,
  }) {
    return GetSportInterestsState(
        errorMessage: errorMessage ?? this.errorMessage,
        data: data ?? this.data,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [errorMessage, status, data];
}
