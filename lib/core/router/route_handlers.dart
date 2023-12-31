import 'package:eldercare_guardian/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:eldercare_guardian/feature/profile/presentation/edit_profile/edit_profile_screen.dart';

import 'package:eldercare_guardian/feature/photo_capture/presentation/take_picture_screen.dart';
import 'package:eldercare_guardian/feature/report_management/presentation/screens/view_aips_and_report/related_report_info_screen.dart';

import 'package:eldercare_guardian/feature/schedule/edit_work_shift/presentation/edit_work_shift_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/authentication/presentation/sign_in/presentation/sign_in_screen.dart';
import '../../feature/bottom_nav_bar.dart';

import '../../feature/report_management/presentation/screens/report_details/report_details_screen.dart';
import '../../feature/splash/presentation/splash_screen.dart';

Handler splashScreenHandler = Handler(
  handlerFunc: (
    BuildContext? context,
    Map<String, List<String>> params,
  ) =>
      const SplashScreen(),
);

Handler signInScreenHandler = Handler(
  handlerFunc: (
    BuildContext? context,
    Map<String, List<String>> params,
  ) =>
      const SignInScreen(),
);

Handler bottomNavBarHandler = Handler(
  handlerFunc: (
    BuildContext? context,
    Map<String, List<String>> params,
  ) =>
      const BottomNavBar(),
);

Handler takePictureScreenHandler = Handler(handlerFunc: (
  BuildContext? context,
  Map<String, List<String>> params,
) {
  final arg = context?.settings?.arguments as Map<String, dynamic>;
  return TakePictureScreen(
    artifactId: arg['artifactId'],
    takePictureScreenPurpose: arg['takePictureScreenPurpose'],
  );
});

Handler editProfileScreenHandler = Handler(
  handlerFunc: (
    BuildContext? context,
    Map<String, List<String>> params,
  ) {
    return BlocProvider.value(
      value: BlocProvider.of<ProfileBloc>(context!)
        ..add(PrepareTemporaryDataEvent()),
      child: const EditProfileScreen(),
    );
  },
);

Handler editWorkShiftScreenHandler = Handler(
  handlerFunc: (
    BuildContext? context,
    Map<String, List<String>> params,
  ) {
    final arg = context?.settings?.arguments as Map<String, dynamic>;
    return EditWorkShiftScreen(
      userAvailableTimeBloc: arg['userAvailableTimeBloc'],
      dateTime: arg['dateTime'],
      workShiftSession: arg['workShiftSession'],
    );
  },
);

Handler reportManagementScreenHandler = Handler(
  handlerFunc: (
    BuildContext? context,
    Map<String, List<String>> params,
  ) {
    return const RelatedReportInfoScreen();
  },
);

Handler reportDetailsScreenHandler = Handler(
  handlerFunc: (
    BuildContext? context,
    Map<String, List<String>> params,
  ) {
    final arg = context?.settings?.arguments as Map<String?, dynamic>;
    return ReportDetailsScreen(
      aip: arg['aip'],
      report: arg['report'],
    );
  },
);
