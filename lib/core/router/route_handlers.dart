import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

Handler splashScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const SplashScreen(),
);

Handler signUpScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const SignInScreen(),
);

Handler otpScreenHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
        const OtpScreen());

Handler bottomNavBarHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const BottomNavBar(),
);

Handler homeScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const HomeScreen(),
);
