import 'package:flutter/material.dart';
import 'package:huylnt_flutter_component/reusable_core/constants/error_message.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';
import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';

import '../automatic_generator/assets.gen.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.sf, horizontal: 0.sf),
        child: Column(
          children: [
            Assets.images.errorResult.image(
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width.sf / 2,
            ),
            18.vSpace,
            Text(
              ErrorMessage.error,
              style: AppTextStyles.custom(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
