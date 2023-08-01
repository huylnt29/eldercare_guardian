import 'package:eldercare_guardian/feature/profile/data/model/education_artifact_model.dart';
import 'package:eldercare_guardian/feature/profile/data/model/experience_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:huylnt_flutter_component/reusable_core/type_defs/email_type.dart';
import 'package:huylnt_flutter_component/reusable_core/type_defs/phone_number_type.dart';
import 'package:isar/isar.dart';
part 'profile_model.g.dart';

@JsonSerializable()
@collection
class Profile {
  Profile({
    required this.id,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.identity,
    this.email,
    this.phoneNumber,
    this.address,
    this.level = Level.none,
    this.avatar,
    @Default([]) required this.educationArtifacts,
    @Default([]) required this.experiences,
  });

  @JsonKey(includeFromJson: false, includeToJson: false)
  Id isarKey = Isar.autoIncrement;

  @JsonKey(name: '_id')
  @Index(unique: true)
  String id;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  @JsonKey(name: 'CCCD')
  @Index(unique: true)
  String? identity;
  Email? email;
  PhoneNumber? phoneNumber;
  String? address;
  @JsonKey(name: 'certificates')
  List<EducationArtifact?> educationArtifacts;
  List<Experience?> experiences;
  @enumerated
  Level level;
  String? avatar;

  factory Profile.fromJson(Map<String, Object?> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  Profile.clone(Profile original)
      : this(
          id: original.id,
          firstName: original.firstName,
          lastName: original.lastName,
          dateOfBirth: original.dateOfBirth,
          identity: original.identity,
          email: original.email,
          phoneNumber: original.phoneNumber,
          address: original.address,
          educationArtifacts: original.educationArtifacts,
          experiences: original.experiences,
        );
}

enum Level {
  @JsonValue('0')
  amateur,
  none;
}
