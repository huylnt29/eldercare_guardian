enum WorkShiftSession {
  morning(7, 11),
  afternoon(1, 5),
  evening(5, 9);

  const WorkShiftSession(this.startTime, this.endTime);
  final int startTime;
  final int endTime;
}

extension WorkShiftSessionX on WorkShiftSession {
  String get text {
    switch (this) {
      case WorkShiftSession.morning:
        return 'Morning shift';
      case WorkShiftSession.afternoon:
        return 'Afternoon shift';
      case WorkShiftSession.evening:
        return 'Evening shift';
    }
  }
}
