part of 'report_bloc.dart';

@freezed
class ReportState with _$ReportState {
  const factory ReportState({
    required List<Aip> aips,
    required List<Report> reports,
    Report? report,
    required LoadState reportLoadState,
    required LoadState aipsLoadState,
    required LoadState reportsLoadState,
    LoadState? postingReportLoadState,
  }) = _ReportState;
}
