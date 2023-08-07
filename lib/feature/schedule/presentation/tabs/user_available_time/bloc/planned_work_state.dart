part of 'planned_work_bloc.dart';

@freezed
class PlannedWorkState with _$PlannedWorkState {
  const factory PlannedWorkState({
    String? aipId,
    @Default([]) List<Aip?> aips,
    required DateTime currentSelectedDate,
    @Default([]) List<Task?> tasks,
    required LoadState loadState,
  }) = _PlannedWorkState;
}
