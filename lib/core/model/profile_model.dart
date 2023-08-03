import 'package:eldercare_guardian/feature/profile/data/model/education_artifact_model.dart';
import 'package:eldercare_guardian/feature/profile/data/model/experience_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:huylnt_flutter_component/reusable_core/type_defs/email_type.dart';
import 'package:huylnt_flutter_component/reusable_core/type_defs/phone_number_type.dart';
import 'package:isar/isar.dart';
part 'profile_model.g.dart';

@JsonSerializable(explicitToJson: true)
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
  @JsonKey(name: 'certificates', includeToJson: false)
  List<EducationArtifact?> educationArtifacts;
  @JsonKey(includeToJson: false)
  List<Experience?> experiences;
  @enumerated
  Level level;
  String? avatar;

  factory Profile.fromJson(Map<String, Object?> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  Profile copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? identity,
    Email? email,
    PhoneNumber? phoneNumber,
    String? address,
    List<EducationArtifact?>? educationArtifacts,
    List<Experience?>? experiences,
    Level? level,
    String? avatar,
  }) {
    return Profile(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      identity: identity ?? this.identity,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      educationArtifacts: educationArtifacts ?? this.educationArtifacts,
      experiences: experiences ?? this.experiences,
      level: level ?? this.level,
      avatar: avatar ?? this.avatar,
    );
  }
}

enum Level {
  @JsonValue('0')
  amateur,
  none;
}
