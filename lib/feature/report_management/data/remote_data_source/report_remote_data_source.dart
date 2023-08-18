part of '../../domain/repository/report_repository.dart';

class ReportRemoteDataSource {
  ReportRemoteDataSource(this.apiClient);
  final ApiClient apiClient;

  Future<List<Aip>> getUnReportedAipByDate(
    String guardianId,
    DateTime dateTime,
  ) async {
    final response = await apiClient.getUnReportedAipByDate(
      guardianId,
      dateTime.yearMonthDay,
    );
    return response;
  }

  Future<List<Report>> getReportsByDate(
    String guardianId,
    DateTime dateTime,
  ) async {
    final response = await apiClient.getReportsByDate(
      guardianId,
      dateTime.yearMonthDay,
    );

    return response;
  }

  Future<Report> getReport(String reportId) async {
    final response = await apiClient.getReport(reportId);
    return response;
  }

  Future<dynamic> postReport(
    String guardianId,
    String aipId,
    Report report,
  ) async {
    final response = await apiClient.postReport(
      guardianId,
      aipId,
      report.toJson(),
    );
    return response;
  }
}
