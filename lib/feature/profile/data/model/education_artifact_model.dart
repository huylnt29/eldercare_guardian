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
    this.editionType = EducationArtifactEditionType.original,
  });
  @JsonKey(name: '_id', includeToJson: false)
  String? id;
  String? title;
  String? description;
  @JsonKey(name: 'image')
  String? imageEvidence;
  @JsonKey(includeFromJson: false, includeToJson: false)
  @enumerated
  EducationArtifactEditionType editionType;
  factory EducationArtifact.fromJson(Map<String, Object?> json) =>
      _$EducationArtifactFromJson(json);

  Map<String, dynamic> toJson() => _$EducationArtifactToJson(this);

  bool get canBePosted => (title != null);
}

enum EducationArtifactEditionType { original, originalModified, draft }
