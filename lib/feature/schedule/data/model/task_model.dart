import 'package:eldercare_guardian/core/converter/datetime_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

import '../../../../core/enums/task_status.dart';
part 'task_model.g.dart';

@JsonSerializable()
class Task {
  Task({
    required this.id,
    required this.title,
    required this.fromDateTime,
    required this.toDateTime,
    @Default(0) this.status,
    this.aipName,
    this.imageEvidencePath,
  });

  factory Task.fromJson(Map<String, Object?> json) => _$TaskFromJson(json);
  @JsonKey(name: '_id')
  String id;
  String title;
  @JsonKey(name: 'startTime')
  DateTime fromDateTime;
  @JsonKey(name: 'endTime')
  DateTime toDateTime;
  @enumerated
  TaskStatus? status;
  String? aipName;
  String? imageEvidencePath;
  String get timeRange {
    return '${DateTimeConverter.getHourMinute(fromDateTime.millisecondsSinceEpoch)} - ${DateTimeConverter.getHourMinute(toDateTime.millisecondsSinceEpoch)}';
  }
}
