// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../feature/authentication/presentation/bloc/authentication_bloc.dart'
    as _i3;
import '../../feature/profile/data/local_data_source/profile_local_data_source.dart'
    as _i4;
import '../../feature/profile/data/remote_data_source/profile_remote_data_source.dart'
    as _i5;
import '../../feature/profile/data/repository/profile_repository_impl.dart'
    as _i7;
import '../../feature/profile/presentation/bloc/profile_bloc.dart' as _i13;
import '../../feature/report_management/domain/repository/report_repository.dart'
    as _i8;
import '../../feature/report_management/presentation/bloc/report_bloc.dart'
    as _i14;
import '../../feature/schedule/view_schedule/data/repository/schedule_repository_impl.dart'
    as _i9;
import '../../feature/schedule/view_schedule/domain/use_case/schedule_use_case.dart'
    as _i10;
import '../../feature/schedule/view_schedule/presentation/tabs/planned_work/bloc/planned_work_bloc.dart'
    as _i12;
import '../../feature/schedule/view_schedule/presentation/tabs/user_available_time/bloc/user_available_time_bloc.dart'
    as _i11;
import '../network/remote/eldercare_server/api_client.dart' as _i6;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.AuthenticationBloc>(() => _i3.AuthenticationBloc());
  gh.factory<_i4.ProfileLocalDataSource>(() => _i4.ProfileLocalDataSource());
  gh.factory<_i5.ProfileRemoteDataSource>(
      () => _i5.ProfileRemoteDataSource(gh<_i6.ApiClient>()));
  gh.factory<_i7.ProfileRepository>(() => _i7.ProfileRepositoryImpl(
        gh<_i4.ProfileLocalDataSource>(),
        gh<_i5.ProfileRemoteDataSource>(),
      ));
  gh.factory<_i8.ReportRemoteDataSource>(
      () => _i8.ReportRemoteDataSource(gh<_i6.ApiClient>()));
  gh.factory<_i8.ReportRepository>(
      () => _i8.ReportRepositoryImpl(gh<_i8.ReportRemoteDataSource>()));
  gh.factory<_i9.ScheduleRemoteDataSource>(
      () => _i9.ScheduleRemoteDataSource(gh<_i6.ApiClient>()));
  gh.factory<_i9.ScheduleRepository>(
      () => _i9.ScheduleRepositoryImpl(gh<_i9.ScheduleRemoteDataSource>()));
  gh.factory<_i10.ScheduleUseCase>(() => _i10.ScheduleUseCase());
  gh.factory<_i11.UserAvailableTimeBloc>(() => _i11.UserAvailableTimeBloc(
        gh<_i9.ScheduleRepository>(),
        gh<_i10.ScheduleUseCase>(),
      ));
  gh.factory<_i12.PlannedWorkBloc>(
      () => _i12.PlannedWorkBloc(gh<_i9.ScheduleRepository>()));
  gh.factory<_i13.ProfileBloc>(
      () => _i13.ProfileBloc(gh<_i7.ProfileRepository>()));
  gh.factory<_i14.ReportBloc>(() => _i14.ReportBloc(
        gh<_i8.ReportRepository>(),
        gh<_i9.ScheduleRepository>(),
      ));
  return getIt;
}
