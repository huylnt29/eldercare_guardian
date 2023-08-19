import 'package:eldercare_guardian/feature/profile/data/model/education_artifact_model.dart';
import 'package:eldercare_guardian/feature/profile/data/model/experience_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:huylnt_flutter_component/reusable_core/constants/error_message.dart';
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
    this.phoneNumber,
    this.address,
    this.level = Level.none,
    this.avatar,
    @Default([]) required this.educationArtifacts,
    @Default([]) required this.experiences,
    this.localLastModifiedAt,
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

  PhoneNumber? phoneNumber;
  String? address;
  @JsonKey(name: 'certificates', includeToJson: false)
  List<EducationArtifact?> educationArtifacts;
  @JsonKey(includeToJson: false)
  List<Experience?> experiences;
  @enumerated
  Level level;
  String? avatar;
  DateTime? localLastModifiedAt;
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
    DateTime? localLastModifiedAt,
  }) {
    return Profile(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      identity: identity ?? this.identity,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      educationArtifacts: educationArtifacts ?? this.educationArtifacts,
      experiences: experiences ?? this.experiences,
      level: level ?? this.level,
      avatar: avatar ?? this.avatar,
      localLastModifiedAt: localLastModifiedAt ?? this.localLastModifiedAt,
    );
  }
}

enum Level {
  @JsonValue('Amateur')
  amateur,
  @JsonValue('Professional')
  professional,
  none;
}

extension LevelX on Level {
  String get text {
    switch (this) {
      case Level.amateur:
        return 'Amateur';
      case Level.professional:
        return 'Professional';
      case Level.none:
        return ErrorMessage.isNotDetermined;
    }
  }
}

extension ProfileX on Profile? {
  bool get isFresh {
    if (this == null) return false;
    if (this!.localLastModifiedAt == null) return false;
    if (this!.localLastModifiedAt!.difference(DateTime.now()).inHours > 1) {
      return false;
    }
    return true;
  }
}
