import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_shift_model.g.dart';

@JsonSerializable()
class WorkShift {
  WorkShift({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.isCycle,
  });

  factory WorkShift.fromJson(Map<String, Object?> json) =>
      _$WorkShiftFromJson(json);

  @JsonKey(name: '_id')
  String id;
  DateTime startTime;
  DateTime endTime;
  bool isCycle;
}

@JsonSerializable()
class DayWorkShift {
  DayWorkShift({
    required this.morningShifts,
    required this.afternoonShifts,
    required this.eveningShifts,
  });

  factory DayWorkShift.fromJson(Map<String, Object?> json) =>
      _$DayWorkShiftFromJson(json);

  @JsonKey(name: 'morning_shift')
  List<WorkShift> morningShifts;
  @JsonKey(name: 'afternoon_shift')
  List<WorkShift> afternoonShifts;
  @JsonKey(name: 'evening_shift')
  List<WorkShift> eveningShifts;
}

@JsonSerializable()
class WeekWorkShift {
  WeekWorkShift({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    this.sunday,
  });

  factory WeekWorkShift.fromJson(Map<String, Object?> json) =>
      _$WeekWorkShiftFromJson(json);

  Map<String, List<WorkShift>> monday;
  Map<String, List<WorkShift>> tuesday;
  Map<String, List<WorkShift>> wednesday;
  Map<String, List<WorkShift>> thursday;
  Map<String, List<WorkShift>> friday;
  Map<String, List<WorkShift>> saturday;
  Map<String, List<WorkShift>>? sunday;
}
