import '../../data/model/work_shift_session_enum.dart';

class ScheduleUseCase {
  ScheduleUseCase();

  bool isWorkShiftSufficientTime(
    WorkShiftSession workShiftSession,
    DateTime startTime,
    DateTime endTime,
  ) {
    return (endTime.difference(startTime).inHours == 4);
  }
}
