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
      ],
      child: MaterialApp(
        onGenerateRoute: Routes.router.generator,
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
