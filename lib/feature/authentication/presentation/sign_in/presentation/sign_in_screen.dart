import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui_modifiers/flutterui_modifiers.dart';
import 'package:huylnt_flutter_component/reusable_core/enums/load_state.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';
import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/button_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/complete_scaffold_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/text_form_field_widget.dart';

import '../../../../../core/automatic_generator/assets.gen.dart';

import '../../../../../core/router/route_config.dart';
import '../../../../../core/router/route_paths.dart';
import '../../../../../core/theme/app_colors.dart';

import '../../bloc/authentication_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late AuthenticationBloc authenticationBloc;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
            Routes.router.navigateTo(
              context,
              RoutePath.bottomNavBar,
              replace: true,
            );
          }
        }
      },
      child: CompleteScaffoldWidget(
        appBarOverlapped: true,
        backButtonEnabled: false,
        appBarTextWidget: const Text(
          'Log in',
          style: TextStyle(color: Colors.white),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(Assets.images.signInScreenBackground.path),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              signInForm(),
            ],
          ),
        ).frame(
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget signInForm() {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.loadState == LoadState.loaded && state.credentialCorrect) {
          Routes.router.navigateTo(context, RoutePath.bottomNavBar);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12.sf,
          horizontal: 5.sf,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 50.sf,
        ),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(18.sf),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                spreadRadius: 3,
                blurRadius: 1,
              )
            ]),
        child: Column(
          children: [
            TextFormFieldWidget(
              controller: emailController,
              labelText: 'Email',
              textInputType: TextInputType.phone,
              colorTheme: AppColors.textColor,
            ),
            TextFormFieldWidget(
              controller: passwordController,
              labelText: 'Password',
              textInputType: TextInputType.text,
              colorTheme: AppColors.textColor,
            ),
            ButtonWidget(
              title: 'Continue',
              backgroundColor: AppColors.accentColor,
              onPressed: () => authenticationBloc.add(EmailPasswordLogInEvent(
                email: emailController.text,
                password: passwordController.text,
              )),
            ),
            Text(
              'Or sign in with',
              style: AppTextStyles.text(
                AppColors.textColor,
              ),
            ),
            18.vSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                authProviderIconButton(Assets.images.google.image(scale: 0.75)),
                18.hSpace,
                authProviderIconButton(
                    Assets.images.microsoft.image(scale: 0.75)),
                18.hSpace,
                authProviderIconButton(Assets.images.apple.image(scale: 0.75)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget authProviderIconButton(Image image) {
    return Container(
      padding: EdgeInsets.all(3.sf),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.sf),
        border: Border.all(
          color: AppColors.textColor,
        ),
      ),
      child: IconButton(
        onPressed: () {},
        icon: image,
      ),
    );
  }
}
