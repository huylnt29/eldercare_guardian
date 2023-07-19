import 'dart:math';

import 'package:eldercare_guardian/core/constants/error_message.dart';
import 'package:eldercare_guardian/core/converter/datetime_converter.dart';
import 'package:eldercare_guardian/core/enums/load_state.dart';
import 'package:eldercare_guardian/core/enums/task_status.dart';
import 'package:eldercare_guardian/core/extensions/font_size_extensions.dart';
import 'package:eldercare_guardian/core/model/aip_model.dart';
import 'package:eldercare_guardian/core/theme/app_colors.dart';
import 'package:eldercare_guardian/core/theme/app_text_styles.dart';
import 'package:eldercare_guardian/core/widgets/button_widget.dart';
import 'package:eldercare_guardian/core/widgets/toast_widget.dart';
import 'package:eldercare_guardian/feature/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../core/automatic_generator/assets.gen.dart';
import '../../../core/router/route_config.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/widgets/list_view_shimmer.dart';
import '../data/model/task_model.dart';
part 'filtering_area.dart';
part 'task_list_area.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const FilteringArea(),
          32.vSpace,
          const TaskListArea(),
        ],
      ),
    );
  }
}
