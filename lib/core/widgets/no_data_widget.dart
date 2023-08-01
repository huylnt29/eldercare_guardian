import 'package:flutter/material.dart';
import 'package:huylnt_flutter_component/reusable_core/constants/error_message.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';
import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';

import '../automatic_generator/assets.gen.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.sf, horizontal: 0.sf),
      child: Column(
        children: [
          Assets.images.emptyResult.image(
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width.sf / 2,
          ),
          12.vSpace,
          Text(
            ErrorMessage.hasNoData,
            style: AppTextStyles.custom(
              fontSize: 14,
            ),
          ),
          12.vSpace,
        ],
      ),
    );
  }
}
