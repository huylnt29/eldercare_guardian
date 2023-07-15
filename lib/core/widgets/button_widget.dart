import 'package:eldercare_guardian/core/extensions/font_size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutterui_modifiers/flutterui_modifiers.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.title,
    this.backgroundColor,
    required this.onPressed,
  }) : super(key: key);
  final Color? backgroundColor;
  final String title;
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.sf,
        vertical: 24.sf,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: backgroundColor ?? AppColors.accentColor,
          shadowColor: Colors.transparent.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.sf),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: AppTextStyles.heading2(AppColors.primaryColor),
        ).padding(
          horizontal: 10.sf,
          vertical: 12.sf,
        ),
      ),
    );
  }
}
