import 'package:eldercare_guardian/feature/profile/presentation/view_profile/widgets/profile_basic_info_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huylnt_flutter_component/reusable_core/constants/error_message.dart';
import 'package:huylnt_flutter_component/reusable_core/enums/load_state.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';
import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/button_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/complete_scaffold_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/rounded_container_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/text_form_field_widget.dart';

import '../../../../../core/model/aip_model.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/loading_dialog.dart';
import '../../../data/model/report_model.dart';
import '../../bloc/report_bloc.dart';

class ReportDetailsScreen extends StatefulWidget {
  const ReportDetailsScreen({this.aip, this.report, super.key});
  final Aip? aip;
  final Report? report;
  @override
  State<ReportDetailsScreen> createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  final reportBloc = getIt<ReportBloc>();
  final summaryController = TextEditingController();
  final aipHealthStatusController = TextEditingController();
  final supportRequestController = TextEditingController();
  final noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => reportBloc,
      child: CompleteScaffoldWidget(
        appBarTextWidget: Text(
          (widget.aip != null) ? 'Write daily report' : 'View report details',
          style: const TextStyle(
            color: AppColors.textColor,
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.sf, vertical: 8.sf),
          child: buildBody(),
        ),
        bottomNavigationBar: (widget.aip != null)
            ? buildSubmitButton()
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: (widget.aip != null)
          ? buildWriteReportSection()
          : buildReportDetailsSection(),
    );
  }

  Widget buildWriteReportSection() {
    return Column(
      children: [
        RoundedContainerWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildBasicAipInfo('Last name', widget.aip!.lastName),
              8.vertical,
              buildBasicAipInfo('Address', widget.aip!.address),
            ],
          ),
        ),
        24.vertical,
        TextFormFieldWidget(
          controller: summaryController,
          labelText: 'Summary',
          textInputType: TextInputType.text,
          colorTheme: AppColors.textColor,
        ),
        TextFormFieldWidget(
          controller: aipHealthStatusController,
          labelText: 'Health status of AIP',
          textInputType: TextInputType.text,
          colorTheme: AppColors.textColor,
        ),
        TextFormFieldWidget(
          controller: supportRequestController,
          labelText: 'Support request',
          textInputType: TextInputType.text,
          colorTheme: AppColors.textColor,
        ),
        TextFormFieldWidget(
          controller: noteController,
          labelText: 'Note',
          textInputType: TextInputType.text,
          colorTheme: AppColors.textColor,
        ),
      ],
    );
  }

  Widget buildBasicAipInfo(String key, String value) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          '$key:',
          style: AppTextStyles.text(
            AppColors.textColor,
            bold: true,
          ).copyWith(height: 0),
        ),
        5.horizontal,
        Text(
          value,
          style:
              AppTextStyles.smallText(AppColors.textColor).copyWith(height: 0),
        ),
      ],
    );
  }

  Widget buildSubmitButton() {
    return BlocConsumer<ReportBloc, ReportState>(
      listener: (context, state) {
        if (state.postingReportLoadState == LoadState.loaded) {
          LoadingDialog.instance.hide();
          Navigator.pop(context, true);
        }
      },
      builder: (context, state) {
        return ButtonWidget(
          title: (state.postingReportLoadState == LoadState.loading)
              ? 'Submitting...'
              : 'Submit',
          disabled: (state.postingReportLoadState == LoadState.loading),
          onPressed: () {
            LoadingDialog.instance.show();
            reportBloc.add(PostReportEvent(
              widget.aip!.id,
              summaryController.text,
              aipHealthStatusController.text,
              supportRequestController.text,
              noteController.text,
            ));
          },
          titleColor: Colors.white,
          backgroundColor: AppColors.accentColor,
        );
      },
    );
  }

  Widget buildReportDetailsSection() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: RoundedContainerWidget(
            child: Text(
              widget.report!.aipName ?? ErrorMessage.isNotDetermined,
              style: AppTextStyles.heading3(AppColors.textColor),
            ),
          ),
        ),
        24.vertical,
        ProfileBasicInfoItem(
          'Summary',
          widget.report!.summary ?? ErrorMessage.isNotDetermined,
        ),
        ProfileBasicInfoItem(
          'Health status of AIP',
          widget.report!.aipHealthStatus ?? ErrorMessage.isNotDetermined,
        ),
        ProfileBasicInfoItem(
          'Support request',
          widget.report!.supportRequest ?? ErrorMessage.isNotDetermined,
        ),
        ProfileBasicInfoItem(
          'Notes',
          widget.report!.note ?? ErrorMessage.isNotDetermined,
        ),
      ],
    );
  }
}
