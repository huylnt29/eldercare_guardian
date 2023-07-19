import 'package:json_annotation/json_annotation.dart';

enum TaskStatus {
  @JsonValue(0)
  notDone(name: 'Not done'),
  @JsonValue(1)
  cancelled(name: 'Cancelled'),
  @JsonValue(2)
  pending(name: 'Pending'),
  @JsonValue(3)
  late(name: 'Late'),
  @JsonValue(4)
  overdue(name: 'Overdue'),
  @JsonValue(5)
  done(name: 'Done');

  final String name;
  const TaskStatus({required this.name});
}
