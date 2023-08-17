import 'package:bloc/bloc.dart';
import 'package:eldercare_guardian/core/model/aip_model.dart';

import 'package:eldercare_guardian/feature/schedule/view_schedule/data/repository/schedule_repository_impl.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:huylnt_flutter_component/reusable_core/enums/load_state.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/date_time.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/logger.dart';

import '../../data/model/report_model.dart';
import '../../domain/repository/report_repository.dart';

part 'report_event.dart';
part 'report_state.dart';
part 'report_bloc.freezed.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc(this.reportRepository, this.scheduleRepository)
      : super(const ReportState(
          aips: [],
          aipsLoadState: LoadState.initial,
          reportsLoadState: LoadState.initial,
          reports: [],
          reportLoadState: LoadState.initial,
        )) {
    on<GetAipsEvent>((event, emit) async {
      emit(state.copyWith(aipsLoadState: LoadState.loading));
      try {
        final response = await scheduleRepository.getAips(DateTime.now());
        emit(state.copyWith(aips: response, aipsLoadState: LoadState.loaded));
      } on Exception catch (error) {
        Logger.e(error);
        emit(state.copyWith(aipsLoadState: LoadState.error));
      }
    });
    on<GetFinishedReportsEvent>((event, emit) async {
      emit(state.copyWith(reportsLoadState: LoadState.loading));
      try {
        final response = await reportRepository.getReportsByDate(
          DateTime.now(),
        );
        emit(state.copyWith(
          reports: response,
          reportsLoadState: LoadState.loaded,
        ));
      } on Exception catch (error) {
        Logger.e(error);
        emit(state.copyWith(reportsLoadState: LoadState.error));
      }
    });

    on<GetReportEvent>((event, emit) async {
      try {
        final response = await reportRepository.getReport(event.reportId);
        emit(state.copyWith(report: response));
      } on Exception catch (error) {
        Logger.e(error);
      }
    });

    on<PostReportEvent>((event, emit) async {
      emit(state.copyWith(postingReportLoadState: LoadState.loading));
      try {
        await reportRepository.postReport(
          event.aipId,
          Report(
            date: DateTime.now().yearMonthDay,
            summary: event.summary,
            aipHealthStatus: event.aipHealthStatus,
            supportRequest: event.supportRequest,
            note: event.note,
          ),
        );
        emit(state.copyWith(postingReportLoadState: LoadState.loaded));
        emit(state.copyWith(postingReportLoadState: LoadState.initial));
      } on Exception catch (error) {
        Logger.e(error);
        emit(state.copyWith(postingReportLoadState: LoadState.error));
      }
    });
  }
  final ReportRepository reportRepository;
  final ScheduleRepository scheduleRepository;
}
