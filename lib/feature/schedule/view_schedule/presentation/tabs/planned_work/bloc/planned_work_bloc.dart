import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:huylnt_flutter_component/reusable_core/enums/load_state.dart';

import '../../../../../../../core/model/aip_model.dart';
import '../../../../data/model/task_model.dart';
import '../../../../data/repository/schedule_repository_impl.dart';

part 'planned_work_event.dart';
part 'planned_work_state.dart';
part 'planned_work_bloc.freezed.dart';

class PlannedWorkBloc extends Bloc<PlannedWorkEvent, PlannedWorkState> {
  PlannedWorkBloc(this.scheduleRepository)
      : super(
          PlannedWorkState(
            currentSelectedDate: DateTime.now(),
            loadState: LoadState.initial,
          ),
        ) {
    on<InitScreenEvent>((event, emit) async {
      emit(state.copyWith(loadState: LoadState.loading));
      final tasks = await scheduleRepository.getAllTasksByDate(
        dateTime: state.currentSelectedDate,
      );
      final aips = await scheduleRepository.getAips();
      emit(state.copyWith(
        tasks: tasks,
        aips: aips,
        loadState: LoadState.loaded,
      ));
    });

    on<ChangeDateTimeEvent>((event, emit) async {
      emit(state.copyWith(loadState: LoadState.loading));

      emit(state.copyWith(
        currentSelectedDate: event.nextDate,
      ));

      final tasks = await scheduleRepository.getAllTasksByDate(
        dateTime: state.currentSelectedDate,
      );

      emit(state.copyWith(
        tasks: tasks,
        loadState: LoadState.loaded,
      ));
    });

    on<ChangeAipEvent>((event, emit) async {
      emit(state.copyWith(loadState: LoadState.loading));

      emit(state.copyWith(
        aipId: event.aipId,
      ));

      final tasks = await scheduleRepository.getAllTasksByDate(
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
        await scheduleRepository.postTaskEvidence(
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

  late ScheduleRepositoryImpl scheduleRepository;
}
