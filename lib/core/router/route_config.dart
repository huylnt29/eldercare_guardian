import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

import 'route_handlers.dart';
import 'route_paths.dart';

class Routes {
  Routes();

  static final router = FluroRouter();
  static RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static void configureRoutes() {
    setRouter(RoutePath.splashScreen, handler: splashScreenHandler);
    setRouter(RoutePath.logInScreen, handler: signInScreenHandler);
    // // setRouter(RoutePath.otpScreen, handler: otpScreenHandler);
    // setRouter(RoutePath.bottomNavBar, handler: bottomNavBarHandler);
    // setRouter(RoutePath.homeScreen, handler: scheduleScreenHandler);
  }

  static void setRouter(String path,
      {required Handler handler, TransitionType? transitionType}) {
    transitionType ??= TransitionType.cupertino;
    router.define(path, handler: handler, transitionType: transitionType);
  }
}
