import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
part 'experience_model.g.dart';

@JsonSerializable()
@embedded
class Experience {
  Experience({
    this.id,
    this.startTime,
    this.endTime,
    this.description,
    this.position,
  });
  @JsonKey(name: '_id')
  String? id;

  DateTime? startTime;
  DateTime? endTime;
  String? description;
  String? position;

  factory Experience.fromJson(Map<String, Object?> json) =>
      _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
