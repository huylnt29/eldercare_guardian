import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:eldercare_guardian/feature/schedule/data/repository/schedule_repository_impl.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:huylnt_flutter_component/reusable_core/enums/load_state.dart';

import '../../../../core/model/aip_model.dart';
import '../../data/model/task_model.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';
part 'schedule_bloc.freezed.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(this.scheduleRepositoryImpl)
      : super(ScheduleState(
          currentSelectedDate: DateTime.now(),
          loadState: LoadState.initial,
        )) {
    on<InitScreenEvent>((event, emit) async {
      emit(state.copyWith(loadState: LoadState.loading));
      final tasks = await scheduleRepositoryImpl.getTasks(
        dateTime: state.currentSelectedDate,
      );
      final aips = await scheduleRepositoryImpl.getAips();
      emit(state.copyWith(
        tasks: tasks,
        aips: aips,
        loadState: LoadState.loaded,
      ));
    });

    on<ChangeDateTimeEvent>((event, emit) {});

    on<ChangeAipEvent>((event, emit) async {
      emit(state.copyWith(loadState: LoadState.loading));

      emit(state.copyWith(
        aipId: event.aipId,
      ));

      final tasks = await scheduleRepositoryImpl.getTasks(
        dateTime: state.currentSelectedDate,
        aipId: event.aipId,
      );

      emit(state.copyWith(
        aipId: event.aipId,
        loadState: LoadState.loaded,
        tasks: tasks,
      ));
    });

    on<ResetStateEvent>((event, emit) {
      emit(state.copyWith(loadState: LoadState.initial));
    });

    on<StateLoadedEvent>((event, emit) {
      emit(state.copyWith(loadState: LoadState.loaded));
    });

    on<PostTaskEvidenceEvent>((event, emit) async {
      emit(state.copyWith(loadState: LoadState.loading));
      try {
        await scheduleRepositoryImpl.postTaskEvidence(
          event.taskId,
          event.xFile,
        );
        emit(state.copyWith(
          loadState: LoadState.loaded,
        ));
      } on Exception {
        emit(state.copyWith(loadState: LoadState.error));
      }
    });
  }

  late ScheduleRepositoryImpl scheduleRepositoryImpl;
}
