part of 'schedule_bloc.dart';

@freezed
class ScheduleState with _$ScheduleState {
  const factory ScheduleState({
    String? aipId,
    @Default([]) List<Aip?> aips,
    required DateTime currentSelectedDate,
    @Default([]) List<Task?> tasks,
    required LoadState loadState,
  }) = _ScheduleState;
}
