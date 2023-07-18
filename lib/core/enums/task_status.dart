import 'package:json_annotation/json_annotation.dart';

enum TaskStatus {
  @JsonValue(0)
  notDone,
  @JsonValue(1)
  cancelled,
  @JsonValue(2)
  pending,
  @JsonValue(3)
  late,
  @JsonValue(4)
  overdue,
  @JsonValue(5)
  done,
}
