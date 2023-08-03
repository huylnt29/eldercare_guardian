import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
part 'experience_model.g.dart';

@JsonSerializable()
@embedded
class Experience {
  Experience({
    this.id,
    this.startDate,
    this.endDate,
    this.description,
    this.position,
    this.editionType = ExperienceEditionType.original,
  });
  @JsonKey(name: '_id', includeToJson: false)
  String? id;

  DateTime? startDate;
  DateTime? endDate;
  String? description;
  @JsonKey(name: 'title')
  String? position;
  @JsonKey(includeFromJson: false, includeToJson: false)
  @enumerated
  ExperienceEditionType editionType;
  factory Experience.fromJson(Map<String, Object?> json) =>
      _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);

  bool get canBePosted => (position != null);
}

enum ExperienceEditionType { original, originalModified, draft }
