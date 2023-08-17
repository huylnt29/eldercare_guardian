import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huylnt_flutter_component/reusable_core/constants/error_message.dart';
import 'package:huylnt_flutter_component/reusable_core/enums/load_state.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';
import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/list_view_shimmer.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/rounded_container_widget.dart';

import '../../../../../core/automatic_generator/assets.gen.dart';
import '../../../../../core/model/aip_model.dart';
import '../../../../../core/router/route_config.dart';
import '../../../../../core/router/route_paths.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/error_widget.dart';
import '../../../../../core/widgets/no_data_widget.dart';
import '../../../data/model/report_model.dart';
import '../../bloc/report_bloc.dart';

part 'tabs/view_aips_tab.dart';
part 'tabs/view_finished_report_tab.dart';

class RelatedReportInfoScreen extends StatefulWidget {
  const RelatedReportInfoScreen({super.key});

  @override
  State<RelatedReportInfoScreen> createState() =>
      _RelatedReportInfoScreenState();
}

class _RelatedReportInfoScreenState extends State<RelatedReportInfoScreen>
    with TickerProviderStateMixin {
  final reportBloc = getIt<ReportBloc>();
  final tabTitles = const [
    Tab(text: 'Day report'),
    Tab(text: 'Finished report'),
  ];
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    reportBloc.add(GetAipsEvent());
    reportBloc.add(GetFinishedReportsEvent());
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
          child: BlocProvider(
            create: (context) => reportBloc,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: const [
                ViewAipsTab(),
                ViewFinishedReportsTab(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
