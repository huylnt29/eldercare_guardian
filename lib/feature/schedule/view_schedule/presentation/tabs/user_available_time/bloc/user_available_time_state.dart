part of 'user_available_time_bloc.dart';

@freezed
class UserAvailableTimeState with _$UserAvailableTimeState {
  const factory UserAvailableTimeState({
    String? guardianId,
    required DateTime currentSelectedDate,
    required List<DateTime> weekDates,
    DayWorkShift? dayWorkShift,
    required LoadState loadState,
    LoadState? postWorkShiftLoadState,
  }) = _UserAvailableTimeState;
}
