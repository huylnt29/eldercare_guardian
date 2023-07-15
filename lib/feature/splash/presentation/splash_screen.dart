import 'package:eldercare_guardian/core/extensions/font_size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui_modifiers/flutterui_modifiers.dart';

import '../../../core/automatic_generator/assets.gen.dart';
import '../../../core/enums/load_state.dart';
import '../../../core/router/route_config.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/complete_scaffold_widget.dart';
import '../../authentication/presentation/bloc/authentication_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthenticationBloc authenticationBloc;
  @override
  void initState() {
    authenticationBloc = context.read<AuthenticationBloc>();
    super.initState();
    // Future.delayed(
    //   const Duration(seconds: 3),
    //   () => authenticationBloc.add(AutoLogInEvent()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.loadState == LoadState.loaded) {
          if (state.canLoginAutomatically) {
            Routes.router.navigateTo(context, RoutePath.bottomNavBar);
          } else {
            Routes.router.navigateTo(context, RoutePath.logInScreen);
          }
        }
      },
      child: CompleteScaffoldWidget(
        appBarOverlapped: true,
        backButtonEnabled: false,
        appBarTitle: 'Eldercare for the Guardian',
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(Assets.images.splashScreenBackground.path),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(36.sf),
            child: Text(
              'Work happily for the elder community',
              textAlign: TextAlign.center,
              style: AppTextStyles.heading1(AppColors.primaryColor).copyWith(
                fontStyle: FontStyle.italic,
              ),
            ).align(Alignment.center),
          ),
        ).frame(
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
