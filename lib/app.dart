import 'package:eldercare_guardian/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:eldercare_guardian/feature/schedule/view_schedule/presentation/tabs/planned_work/bloc/planned_work_bloc.dart';
import 'package:eldercare_guardian/feature/schedule/view_schedule/presentation/tabs/user_available_time/bloc/user_available_time_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/route_config.dart';
import 'core/service_locator/service_locator.dart';
import 'feature/authentication/presentation/bloc/authentication_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return buildMultiBlocAppProvider(
      MaterialApp(
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

  Widget buildMultiBlocAppProvider(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthenticationBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<ProfileBloc>(),
        ),
      ],
      child: child,
    );
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
