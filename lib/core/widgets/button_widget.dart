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
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: backgroundColor ?? AppColors.accentColor,
          shadowColor: Colors.transparent.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: AppTextStyles.heading2(AppColors.secondaryColor),
        ).padding(
          horizontal: 10,
          vertical: 12,
        ),
      ),
    );
  }
}
