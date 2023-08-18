import 'package:eldercare_guardian/core/faked/faked_data.dart';

import 'package:huylnt_flutter_component/reusable_core/extensions/date_time.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/model/aip_model.dart';
import '../../../../core/network/remote/eldercare_server/api_client.dart';
import '../../data/model/report_model.dart';

part '../../data/remote_data_source/report_remote_data_source.dart';

abstract class ReportRepository {
  ReportRepository(this.remoteDataSource);
  final ReportRemoteDataSource remoteDataSource;

  Future<List<Aip>> getUnReportedAipByDate(
    DateTime dateTime,
  );

  Future<List<Report>> getReportsByDate(
    DateTime dateTime,
  );

  Future<Report> getReport(
    String reportId,
  );

  Future<dynamic> postReport(
    String aipId,
    Report report,
  );
}

@Injectable(as: ReportRepository)
class ReportRepositoryImpl extends ReportRepository {
  ReportRepositoryImpl(super.remoteDataSource);

  @override
  Future<List<Aip>> getUnReportedAipByDate(
    DateTime dateTime,
  ) async {
    return remoteDataSource.getUnReportedAipByDate(
      FakedData.guardianId,
      dateTime,
    );
  }

  @override
  Future<List<Report>> getReportsByDate(DateTime dateTime) async {
    return remoteDataSource.getReportsByDate(FakedData.guardianId, dateTime);
  }

  @override
  Future<Report> getReport(String reportId) async {
    return remoteDataSource.getReport(reportId);
  }

  @override
  Future<dynamic> postReport(
    String aipId,
    Report report,
  ) async {
    return remoteDataSource.postReport(FakedData.guardianId, aipId, report);
  }
}
