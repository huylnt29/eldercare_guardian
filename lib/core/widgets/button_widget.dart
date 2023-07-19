import 'package:eldercare_guardian/core/extensions/font_size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutterui_modifiers/flutterui_modifiers.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.title,
    this.titleColor,
    this.backgroundColor,
    required this.onPressed,
    this.disabled = false,
  }) : super(key: key);
  final Color? backgroundColor;
  final String title;
  final Color? titleColor;
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;
  final bool disabled;
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
          backgroundColor: (disabled)
              ? AppColors.disableBackgroundColor
              : (backgroundColor ?? AppColors.accentColor),
          shadowColor: Colors.transparent.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.sf),
          ),
        ),
        onPressed: (!disabled) ? onPressed : null,
        child: Text(
          title,
          style: AppTextStyles.heading2(titleColor ?? AppColors.primaryColor),
        ).padding(
          horizontal: 10.sf,
          vertical: 12.sf,
        ),
      ),
    );
  }
}
