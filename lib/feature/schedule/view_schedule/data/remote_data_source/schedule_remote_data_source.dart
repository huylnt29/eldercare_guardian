part of '../repository/schedule_repository_impl.dart';

class ScheduleRemoteDataSource {
  ScheduleRemoteDataSource(this.apiClient);
  final ApiClient apiClient;

  Future<List<Task>> getAllTasksByDate(
    String guardianId,
    DateTime dateTime,
  ) async {
    final response = await apiClient.getTasks(
      guardianId,
      dateTime.yearMonthDay,
    );
    return response;
    // return [];
  }

  Future<List<Task>> getTasksByAipId(String aipId, DateTime dateTime) async {
    return [
      Task.fromJson({
        'id': 't124',
        'title': 'Clean the floor',
        'fromDateTime': DateTime.now().toIso8601String(),
        'toDateTime': DateTime.now().toIso8601String(),
        'status': 0,
      }),
    ];
  }

  Future<List<Aip>> getAipsByDate(String guardianId, DateTime dateTime) async {
    final response = await apiClient.getAipByDate(
      guardianId,
      dateTime.yearMonthDay,
    );
    return response;
  }

  Future<bool> postTaskEvidence(String taskId, File file) async {
    Logger.v('[Data layer] Posting task evidence');

    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });
    try {
      await Dio().post(
        '${dotenv.env['ELDERCARE_SERVER_URL']}/task/upload/$taskId',
        data: formData,
      );
      return true;
    } catch (error) {
      Logger.e(error);
      return false;
    }
  }

  Future<DayWorkShift> getScheduleByDate(
    String guardianId,
    DateTime dateTime,
  ) async {
    final response = await apiClient.getScheduleByDate(
      guardianId,
      dateTime.yearMonthDay,
    );
    return response;
  }

  Future<WorkShift> postShift(String guardianId, WorkShift workShift) async {
    final response = await apiClient.postShift(
      workShift.toJson()..addEntries([MapEntry('guardian', guardianId)]),
    );
    return response;
  }

  Future<dynamic> deleteShift(String workShiftId) async {
    final response = await apiClient.deleteWorkShift(
      workShiftId,
    );
    return response;
  }
}
