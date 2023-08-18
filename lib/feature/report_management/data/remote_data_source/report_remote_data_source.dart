part of '../../domain/repository/report_repository.dart';

class ReportRemoteDataSource {
  ReportRemoteDataSource(this.apiClient);
  final ApiClient apiClient;

  Future<List<Report>> getReportsByDate(
    String guardianId,
    DateTime dateTime,
  ) async {
    final response = await apiClient.getReportsByDate(
      guardianId,
      dateTime.yearMonthDay,
    );

    return response;
    // return [];
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
