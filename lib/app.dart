import 'package:eldercare_guardian/feature/profile/data/local_data_source/profile_local_data_source.dart';
import 'package:eldercare_guardian/feature/profile/data/remote_data_source/profile_remote_data_source.dart';
import 'package:eldercare_guardian/feature/profile/data/repository/profile_repository_impl.dart';
import 'package:eldercare_guardian/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:eldercare_guardian/feature/schedule/data/repository/schedule_repository_impl.dart';
import 'package:eldercare_guardian/feature/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/route_config.dart';
import 'core/service_locator/service_locator.dart';
import 'feature/authentication/presentation/bloc/authentication_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (_) => ScheduleBloc(
            ScheduleRepositoryImpl(
              ScheduleRemoteDataSource(
                getIt(),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => ProfileBloc(
            ProfileRepositoryImpl(
              ProfileLocalDataSource(),
              ProfileRemoteDataSource(
                getIt(),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => child!,
              ),
            ],
          );
        },
        onGenerateRoute: Routes.router.generator,
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
      ),
    );
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
