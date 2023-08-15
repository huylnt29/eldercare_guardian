import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:eldercare_guardian/core/faked/faked_data.dart';
import 'package:eldercare_guardian/core/model/aip_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:huylnt_flutter_component/reusable_core/extensions/date_time.dart';

import '../../../../../core/network/remote/eldercare_server/api_client.dart';

import '../model/task_model.dart';
import '../model/work_shift_model.dart';

part '../remote_data_source/schedule_remote_data_source.dart';

class ScheduleRepositoryImpl {
  ScheduleRepositoryImpl(this.scheduleRemoteDataSource);
  ScheduleRemoteDataSource scheduleRemoteDataSource;

  Future<List<Task>> getAllTasksByDate({
    String? aipId,
    required DateTime dateTime,
  }) async {
    if (aipId == null) {
      return await scheduleRemoteDataSource.getAllTasksByDate(
        FakedData.guardianId,
        dateTime,
      );
    } else {
      return await scheduleRemoteDataSource.getTasksByAipId(
        aipId,
        dateTime,
      );
    }
  }

  Future<List<Aip>> getAips(DateTime dateTime) async {
    return await scheduleRemoteDataSource.getAipsByDate(
      FakedData.guardianId,
      dateTime,
    );
  }

  Future<bool> postTaskEvidence(String taskId, XFile xFile) async {
    return await scheduleRemoteDataSource.postTaskEvidence(
      taskId,
      File(xFile.path),
    );
  }

  Future<DayWorkShift> getScheduleByDate(DateTime dateTime) async {
    return await scheduleRemoteDataSource.getScheduleByDate(
      FakedData.guardianId,
      dateTime,
    );
  }

  Future<WorkShift> postShift(WorkShift workShift) async {
    final response = await scheduleRemoteDataSource.postShift(
      FakedData.guardianId,
      workShift,
    );
    return response;
  }

  Future<dynamic> deleteShift(WorkShift workShift) async {
    final response = await scheduleRemoteDataSource.deleteShift(workShift.id);
    return response;
  }
}
