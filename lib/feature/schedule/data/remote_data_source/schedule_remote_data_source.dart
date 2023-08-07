part of '../repository/schedule_repository_impl.dart';

class ScheduleRemoteDataSource {
  ScheduleRemoteDataSource(this._elderCareClient);
  final ElderCareClient _elderCareClient;

  Future<List<Task>> getAllTasksByDate(DateTime dateTime) async {
    final response = await _elderCareClient.getTasks(
      FakedData.guardianId,
      DateTimeConverter.getYearMonthDay(
        dateTime.millisecondsSinceEpoch,
      ),
    );
    return response;
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

  Future<List<Aip>> getAips() async {
    return [
      Aip.fromJson({
        'id': '1',
        'firstName': 'Le',
        'lastName': 'Huy',
        'CCCD': '092202',
        'phoneNumber': '090914243',
        'dateOfBirth': '29/01/2002',
        'address': '32 Ha Ba Tuong street',
      }),
      Aip.fromJson({
        'id': '2',
        'firstName': 'Le',
        'lastName': 'Phu',
        'CCCD': '092202',
        'phoneNumber': '090914243',
        'dateOfBirth': '29/01/2002',
        'address': '32 Ha Ba Tuong street',
      })
    ];
  }

  Future<bool> postTaskEvidence(String taskId, File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
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
    } catch (e) {
      return false;
    }
  }
}
