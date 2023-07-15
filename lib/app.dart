import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/route_config.dart';
import 'core/service_locator/service_locator.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthenticationBloc(
            AuthenticationUseCase(
              authenticationRepository: AuthenticationRepositoryImpl(
                authenticationRemoteDataSource: AuthenticationRemoteDataSource(
                  getIt(),
                ),
                authenticationLocalDataSource: AuthenticationLocalDataSource(),
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
