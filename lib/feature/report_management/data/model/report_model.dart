import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'report_model.g.dart';

@JsonSerializable()
class Report {
  Report({
    this.id,
    this.guardianId,
    this.aipId,
    required this.date,
    this.summary,
    this.aipHealthStatus,
    this.note,
    this.supportRequest,
  });

  factory Report.fromJson(Map<String, Object?> json) => _$ReportFromJson(json);
  Map<String, dynamic> toJson() => _$ReportToJson(this);

  @JsonKey(name: '_id', includeToJson: false)
  String? id;

  @JsonKey(name: 'guardian', includeToJson: false)
  String? guardianId;

  @JsonKey(name: 'aip', includeToJson: false)
  String? aipId;
  String date;

  @JsonKey(name: 'summarization')
  String? summary;

  @JsonKey(name: 'healthStatusOfAip')
  String? aipHealthStatus;

  String? supportRequest;
  String? note;
}
