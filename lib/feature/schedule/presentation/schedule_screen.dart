import 'package:eldercare_guardian/core/widgets/error_widget.dart';
import 'package:eldercare_guardian/core/widgets/loading_dialog.dart';
import 'package:eldercare_guardian/core/widgets/no_data_widget.dart';
import 'package:eldercare_guardian/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:eldercare_guardian/feature/schedule/data/repository/schedule_repository_impl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:huylnt_flutter_component/reusable_core/constants/error_message.dart';
import 'package:huylnt_flutter_component/reusable_core/converter/datetime_converter.dart';
import 'package:huylnt_flutter_component/reusable_core/enums/load_state.dart';

import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';
import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/list_view_shimmer.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/rounded_container_widget.dart';

import '../../../core/automatic_generator/assets.gen.dart';
import '../../../core/router/route_config.dart';
import '../../../core/router/route_paths.dart';

import '../../../core/service_locator/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../photo_capture/presentation/take_picture_screen.dart';
import '../data/model/task_model.dart';
import 'tabs/planned_work/bloc/planned_work_bloc.dart';

part 'tabs/planned_work/filtering_area.dart';
part 'tabs/planned_work/task_list_area.dart';
part 'tabs/planned_work/planned_work_tab.dart';
part 'tabs/user_available_time/user_available_time_tab.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with TickerProviderStateMixin {
  final tabTitles = const [
    Tab(text: 'Planned work'),
    Tab(text: 'My available time'),
  ];
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          tabs: tabTitles,
          controller: tabController,
          indicatorColor: AppColors.accentColor,
          unselectedLabelColor: AppColors.textColor,
          labelColor: AppColors.textColor,
          labelStyle: const TextStyle(fontWeight: FontWeight.w700),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          indicatorPadding: EdgeInsets.only(bottom: 5.sf),
        ),
        8.vSpace,
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              PlannedWorkTab(),
              const UserAvailableTimeTab(),
            ],
          ),
        )
      ],
    );
  }
}
