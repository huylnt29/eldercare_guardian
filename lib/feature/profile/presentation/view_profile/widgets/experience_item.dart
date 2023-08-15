import 'package:eldercare_guardian/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:huylnt_flutter_component/reusable_core/constants/error_message.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/date_time.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';
import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';

class ExperienceItem extends StatelessWidget {
  const ExperienceItem(
      this.position, this.description, this.startDate, this.endDate,
      {Key? key})
      : super(key: key);
  final String position;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  position,
                  style: AppTextStyles.heading3(AppColors.textColor),
                ),
                3.vSpace,
                (description != null)
                    ? Text(description.toString())
                    : const Text(ErrorMessage.hasNoDescription),
              ],
            ),
          ),
        ),
        18.hSpace,
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 1.sf,
            vertical: 10.sf,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 18.sf,
            vertical: 10.sf,
          ),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(18.sf),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(startDate.beautifulDate),
              SizedBox(
                width: 75.sf,
                child: Divider(
                  thickness: 2.sf,
                  color: AppColors.secondaryColor,
                ),
              ),
              Text(endDate.beautifulDate),
            ],
          ),
        )
      ],
    );
  }
}
