import 'package:eldercare_guardian/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:huylnt_flutter_component/reusable_core/constants/error_message.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';
import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';

class ProfileBasicInfoItem extends StatelessWidget {
  const ProfileBasicInfoItem(
    this.title,
    this.value, {
    Key? key,
  }) : super(key: key);
  final String title;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 1.sf,
        vertical: 10.sf,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 18.sf,
        vertical: 10.sf,
      ),
      decoration: BoxDecoration(
        color: AppColors.textColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18.sf),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.heading3(AppColors.textColor),
          ),
          3.vSpace,
          (value != null)
              ? Text(value.toString())
              : const Text(ErrorMessage.isNotDetermined),
        ],
      ),
    );
  }
}
