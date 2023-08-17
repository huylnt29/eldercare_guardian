import 'package:eldercare_guardian/core/faked/faked_data.dart';
import 'package:eldercare_guardian/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:huylnt_flutter_component/reusable_core/constants/error_message.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';
import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/cached_network_image_widget.dart';

class EducationArtifactItem extends StatelessWidget {
  const EducationArtifactItem(
    this.title,
    this.description,
    this.imageEvidence, {
    Key? key,
  }) : super(key: key);
  final String title;
  final String? description;
  final String? imageEvidence;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
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
                (description != null)
                    ? Text(description.toString())
                    : const Text(ErrorMessage.hasNoDescription),
              ],
            ),
          ),
        ),
        12.hSpace,
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CachedNetWorkImageWidget(
            width: 72.sf,
            height: 72.sf,
            imageUrl: imageEvidence ?? FakedData.emptyImagePath,
          ),
        ),
      ],
    );
  }
}
