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
      ],
      child: MaterialApp(
        onGenerateRoute: Routes.router.generator,
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
