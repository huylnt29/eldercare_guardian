part of '../repository/schedule_repository_impl.dart';

class ScheduleRemoteDataSource {
  ScheduleRemoteDataSource(this._elderCareClient);
  final ElderCareClient _elderCareClient;

  Future<List<Task>> getAllTasks(DateTime dateTime) async {
    // return [
    //   Task.fromJson({
    //     'id': 't124',
    //     'title': 'Clean the floor',
    //     'fromDateTime': DateTime.now().toIso8601String(),
    //     'toDateTime': DateTime.now().toIso8601String(),
    //     'status': 0,
    //     'aipName': 'Nguyen Thien Phu',
    //   }),
    //   Task.fromJson({
    //     'id': 't125',
    //     'title': 'Wash the dishes',
    //     'fromDateTime': DateTime.now().toIso8601String(),
    //     'toDateTime': DateTime.now().toIso8601String(),
    //     'status': 5,
    //     'aipName': 'Tran Thien Kim',
    //     'imageEvidencePath':
    //         'https://images.pexels.com/photos/709767/pexels-photo-709767.png?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    //   }),
    //   Task.fromJson({
    //     'id': 't120',
    //     'title': 'Wash the dishes',
    //     'fromDateTime': DateTime.now().toIso8601String(),
    //     'toDateTime': DateTime.now().toIso8601String(),
    //     'status': 3,
    //     'aipName': 'Tran Thien Kim',
    //   }),
    // ];
    // try {
    //   final response =
    //       await _elderCareClient.getTasks('64b76229250c2f0f19bb1c8a');
    //   return response;
    // } catch (e) {
    //   Logger.e(e);
    // }
    // return [];
    final response =
        await _elderCareClient.getTasks('64b76229250c2f0f19bb1c8a');
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
      final response = await Dio().post(
        'https://eldercare.up.railway.app/task/upload/$taskId',
        data: formData,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
