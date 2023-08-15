import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'app.dart';
import 'core/network/local/isar/isar_database.dart';
import 'core/network/remote/eldercare_server/api_client_config.dart';
import 'core/router/route_config.dart';
import 'core/service_locator/service_locator.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await dotenv.load();

    configureDependencies(
      dio: ApiClientConfig.initApiService(
        baseUrl: dotenv.env['ELDERCARE_SERVER_URL'],
      ),
    );

    await IsarDatabase.init();

    Intl.defaultLocale = 'en_US';
    await initializeDateFormatting();
    Routes.configureRoutes();

    runApp(const App());
  }, (error, stackTrace) async {
    throw error;
  });
}
