import 'package:json_annotation/json_annotation.dart';
part 'aip_model.g.dart';

@JsonSerializable()
class Aip {
  Aip({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.identity,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.address,
  });

  factory Aip.fromJson(Map<String, Object?> json) => _$AipFromJson(json);

  String id;
  String firstName;
  String lastName;
  @JsonKey(name: 'CCCD')
  String identity;
  String phoneNumber;
  String dateOfBirth;
  String address;
}
