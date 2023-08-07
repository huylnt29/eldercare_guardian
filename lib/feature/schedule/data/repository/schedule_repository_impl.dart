import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:eldercare_guardian/core/faked/faked_data.dart';
import 'package:eldercare_guardian/core/model/aip_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:huylnt_flutter_component/reusable_core/converter/datetime_converter.dart';

import '../../../../core/network/remote/eldercare_server/eldercare_client.dart';
import '../model/task_model.dart';

part '../remote_data_source/schedule_remote_data_source.dart';

class ScheduleRepositoryImpl {
  ScheduleRepositoryImpl(this.scheduleRemoteDataSource);
  ScheduleRemoteDataSource scheduleRemoteDataSource;

  Future<List<Task>> getAllTasksByDate({
    String? aipId,
    required DateTime dateTime,
  }) async {
    if (aipId == null) {
      return await scheduleRemoteDataSource.getAllTasksByDate(dateTime);
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
