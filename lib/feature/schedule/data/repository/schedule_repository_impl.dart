import 'dart:io';

import 'package:camera/camera.dart';
import 'package:eldercare_guardian/core/extensions/logger.dart';
import 'package:eldercare_guardian/core/model/aip_model.dart';

import '../../../../core/network/remote/eldercare_server/eldercare_client.dart';
import '../model/task_model.dart';

part '../remote_data_source/schedule_remote_data_source.dart';

class ScheduleRepositoryImpl {
  ScheduleRepositoryImpl(this.scheduleRemoteDataSource);
  ScheduleRemoteDataSource scheduleRemoteDataSource;

  Future<List<Task>> getTasks({
    String? aipId,
    required DateTime dateTime,
  }) async {
    if (aipId == null) {
      return await scheduleRemoteDataSource.getAllTasks(dateTime);
    } else {
      return await scheduleRemoteDataSource.getTasksByAipId(aipId, dateTime);
    }
  }

  Future<List<Aip>> getAips() async {
    return await scheduleRemoteDataSource.getAips();
  }

  Future<bool> postTaskEvidence(String taskId, XFile xFile) async {
    return await scheduleRemoteDataSource.postTaskEvidence(
      taskId,
      File(xFile.path),
    );
  }
}
