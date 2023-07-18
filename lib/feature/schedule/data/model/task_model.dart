import 'package:eldercare_guardian/core/converter/datetime_converter.dart';
import 'package:isar/isar.dart';

import '../../../../core/enums/task_status.dart';
import 'package:json_annotation/json_annotation.dart';
part 'task_model.g.dart';

@JsonSerializable()
class Task {
  Task({
    required this.id,
    required this.title,
    required this.fromDateTime,
    required this.toDateTime,
    required this.status,
    this.aipName,
    this.imageEvidencePath,
  });

  factory Task.fromJson(Map<String, Object?> json) => _$TaskFromJson(json);
  String id;
  String title;
  DateTime fromDateTime;
  DateTime toDateTime;
  @enumerated
  TaskStatus status;
  String? aipName;
  String? imageEvidencePath;
  String get timeRange {
    return '${DateTimeConverter.getHourMinute(fromDateTime.millisecondsSinceEpoch)} - ${DateTimeConverter.getHourMinute(toDateTime.millisecondsSinceEpoch)}';
  }
}
