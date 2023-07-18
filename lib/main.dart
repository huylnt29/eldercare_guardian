import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'core/network/local/isar/isar_database.dart';
import 'core/network/remote/eldercare_server/eldercare_client_config.dart';
import 'core/router/route_config.dart';
import 'core/service_locator/service_locator.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await dotenv.load();

    configureDependencies(
      dio: ElderCareClientConfig.initApiService(
        baseUrl: dotenv.env['ELDERCARE_SERVER_URL'],
      ),
    );

    // await IsarDatabase.init();

    Routes.configureRoutes();

    runApp(const App());
  }, (error, stackTrace) async {
    throw error;
  });
}
