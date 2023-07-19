part of 'schedule_bloc.dart';

@freezed
class ScheduleState with _$ScheduleState {
  const factory ScheduleState({
    String? aipId,
    @Default([]) List<Aip?> aips,
    required DateTime currentSelectedDate,
    @Default([]) List<Task?> tasks,
    @Default(false) bool postTaskEvidenceSuccessfully,
    required LoadState loadState,
  }) = _ScheduleState;
}
