import 'package:eldercare_guardian/core/widgets/error_widget.dart';
import 'package:eldercare_guardian/core/widgets/loading_dialog.dart';
import 'package:eldercare_guardian/core/widgets/no_data_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:huylnt_flutter_component/reusable_core/constants/error_message.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/date_time.dart';
import 'package:huylnt_flutter_component/reusable_core/enums/load_state.dart';

import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';
import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/action_dialog_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/cached_network_image_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/list_view_shimmer.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/rounded_container_widget.dart';

import '../../../../core/automatic_generator/assets.gen.dart';
import '../../../../core/router/route_config.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/theme/app_colors.dart';

import '../../../photo_capture/presentation/take_picture_screen.dart';
import '../data/model/task_model.dart';
import '../data/model/work_shift_model.dart';
import '../data/model/work_shift_session_enum.dart';
import '../data/repository/schedule_repository_impl.dart';

import 'tabs/planned_work/bloc/planned_work_bloc.dart';
import 'tabs/user_available_time/bloc/user_available_time_bloc.dart';

part 'tabs/planned_work/filtering_area.dart';
part 'tabs/planned_work/task_list_area.dart';
part 'tabs/planned_work/planned_work_tab.dart';
part 'tabs/user_available_time/user_available_time_tab.dart';
part 'tabs/user_available_time/date_tab_bar_item.dart';
part 'tabs/user_available_time/date_tab_bar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with TickerProviderStateMixin {
  final tabTitles = const [
    Tab(text: 'Planned work'),
    Tab(text: 'Next week'),
  ];
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 40.sf,
          child: TabBar(
            labelPadding: EdgeInsets.zero,
            tabs: tabTitles,
            controller: tabController,
            indicatorColor: AppColors.accentColor,
            unselectedLabelColor: AppColors.textColor,
            labelColor: AppColors.textColor,
            labelStyle: AppTextStyles.text(
              AppColors.textColor,
              bold: true,
            ),
            unselectedLabelStyle: AppTextStyles.text(
              AppColors.textColor,
              bold: false,
            ),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.sf, color: AppColors.accentColor),
              insets: EdgeInsets.symmetric(horizontal: 18.sf),
            ),
          ),
        ),
        8.vSpace,
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: const [
              PlannedWorkTab(),
              UserAvailableTimeTab(),
            ],
          ),
        ),
      ],
    );
  }
}
