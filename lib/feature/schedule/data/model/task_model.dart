import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

import '../../../../core/enums/task_status.dart';
part 'task_model.g.dart';

@JsonSerializable()
class Task {
  Task({
    required this.id,
    required this.title,
    @Default(false) required this.isDone,
    @Default(0) this.status,
    this.aipName,
    this.taskEvidence,
  });

  factory Task.fromJson(Map<String, Object?> json) => _$TaskFromJson(json);
  @JsonKey(name: '_id')
  String id;
  String title;
  bool isDone;
  @enumerated
  TaskStatus? status;
  String? aipName;
  @JsonKey(name: 'image')
  TaskEvidence? taskEvidence;
}

@JsonSerializable()
class TaskEvidence {
  TaskEvidence({
    required this.id,
    required this.imageEvidencePath,
    this.latitude,
    this.longtitude,
    this.address,
  });

  factory TaskEvidence.fromJson(Map<String, Object?> json) =>
      _$TaskEvidenceFromJson(json);

  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'link')
  String imageEvidencePath;
  double? latitude;
  double? longtitude;
  String? address;
}
