import 'package:bloc/bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:huylnt_flutter_component/reusable_core/enums/load_state.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/date_time.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/logger.dart';

import '../../../../../../../core/service_locator/service_locator.dart';
import '../../../../data/model/work_shift_model.dart';
import '../../../../data/repository/schedule_repository_impl.dart';
import '../../../../domain/use_case/schedule_use_case.dart';

part 'user_available_time_event.dart';
part 'user_available_time_state.dart';
part 'user_available_time_bloc.freezed.dart';

class UserAvailableTimeBloc
    extends Bloc<UserAvailableTimeEvent, UserAvailableTimeState> {
  UserAvailableTimeBloc(this.scheduleRepository, this.scheduleUseCase)
      : super(
          UserAvailableTimeState(
            currentSelectedDate: DateTime.now().firstDayOfNextWeek,
            weekDates: DateTime.now().add(const Duration(days: 7)).weekDates,
            loadState: LoadState.initial,
            postWorkShiftLoadState: LoadState.initial,
          ),
        ) {
    on<FetchDayWorkShift>((event, emit) async {
      emit(state.copyWith(loadState: LoadState.loading));
      try {
        final response = await scheduleRepository.getScheduleByDate(event.date);
        emit(state.copyWith(
          loadState: LoadState.loaded,
          dayWorkShift: response,
        ));
      } catch (error) {
        emit(state.copyWith(loadState: LoadState.error));
      }
    });

    on<PostWorkShift>((event, emit) async {
      Logger.v('Right before posting new work shift');
      Logger.d(event.workShift.toJson());

      emit(state.copyWith(postWorkShiftLoadState: LoadState.loading));

      try {
        await scheduleRepository.postShift(event.workShift);
        emit(state.copyWith(postWorkShiftLoadState: LoadState.loaded));
        emit(state.copyWith(postWorkShiftLoadState: LoadState.initial));
      } on Exception catch (error) {
        Logger.e(error);
        emit(state.copyWith(postWorkShiftLoadState: LoadState.error));
      }
    });

    on<DeleteWorkShift>((event, emit) async {
      Logger.v('Right before deleting work shift');
      Logger.d(event.workShift.toJson());

      emit(state.copyWith(loadState: LoadState.loading));

      try {
        await scheduleRepository.deleteShift(event.workShift);
        Logger.v('Work shift has been deleted');
        add(FetchDayWorkShift(state.currentSelectedDate));
      } on Exception catch (error) {
        Logger.e(error);
        emit(state.copyWith(postWorkShiftLoadState: LoadState.error));
      }
    });
  }

  final ScheduleUseCase scheduleUseCase;
  final ScheduleRepository scheduleRepository;
}
