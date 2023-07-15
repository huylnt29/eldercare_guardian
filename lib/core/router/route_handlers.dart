import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

import '../../feature/authentication/presentation/log_in/presentation/sign_in_screen.dart';
import '../../feature/splash/presentation/splash_screen.dart';

Handler splashScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const SplashScreen(),
);

Handler signInScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const SignInScreen(),
);

// // Handler otpScreenHandler = Handler(
// //     handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
// //         const OtpScreen());

// Handler bottomNavBarHandler = Handler(
//   handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
//       const BottomNavBar(),
// );

// Handler scheduleScreenHandler = Handler(
//   handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
//       const ScheduleScreen(),
// );
