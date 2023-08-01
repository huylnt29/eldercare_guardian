import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
part 'education_artifact_model.g.dart';

@JsonSerializable()
@embedded
class EducationArtifact {
  EducationArtifact({
    this.id,
    this.title,
    this.description,
    this.imageEvidence,
  });
  @JsonKey(name: '_id')
  String? id;
  String? title;
  String? description;
  @JsonKey(name: 'image')
  String? imageEvidence;

  factory EducationArtifact.fromJson(Map<String, Object?> json) =>
      _$EducationArtifactFromJson(json);

  Map<String, dynamic> toJson() => _$EducationArtifactToJson(this);
}
