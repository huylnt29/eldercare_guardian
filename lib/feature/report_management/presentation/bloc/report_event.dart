part of 'report_bloc.dart';

abstract class ReportEvent {}

class GetAipsEvent extends ReportEvent {
  GetAipsEvent();
}

class GetFinishedReportsEvent extends ReportEvent {
  GetFinishedReportsEvent();
}

class GetReportEvent extends ReportEvent {
  GetReportEvent(this.reportId);
  final String reportId;
}

class PostReportEvent extends ReportEvent {
  PostReportEvent(
    this.aipId,
    this.summary,
    this.aipHealthStatus,
    this.supportRequest,
    this.note,
  );
  final String aipId;
  final String summary;
  final String aipHealthStatus;
  final String supportRequest;
  final String note;
}
