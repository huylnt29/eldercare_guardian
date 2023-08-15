import 'package:eldercare_guardian/feature/schedule/view_schedule/data/model/work_shift_model.dart';
import 'package:eldercare_guardian/feature/schedule/view_schedule/data/model/work_shift_session_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huylnt_flutter_component/reusable_core/enums/load_state.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/date_time.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';
import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/button_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/complete_scaffold_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/rounded_container_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/text_form_field_widget.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/loading_dialog.dart';
import '../../view_schedule/presentation/tabs/user_available_time/bloc/user_available_time_bloc.dart';

class EditWorkShiftScreen extends StatefulWidget {
  const EditWorkShiftScreen({
    required this.userAvailableTimeBloc,
    required this.dateTime,
    required this.workShiftSession,
    this.workShift,
    super.key,
  });
  final DateTime dateTime;
  final WorkShiftSession workShiftSession;
  final WorkShift? workShift;
  final UserAvailableTimeBloc userAvailableTimeBloc;
  @override
  State<EditWorkShiftScreen> createState() => _EditWorkShiftScreenState();
}

class _EditWorkShiftScreenState extends State<EditWorkShiftScreen> {
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  final cycleTimeChanged = ValueNotifier(false);
  late WorkShift workShift;

  @override
  void initState() {
    if (widget.workShift == null) {
      workShift = WorkShift(
        id: '',
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 4)),
        isCycle: false,
      );
    } else {
      workShift = widget.workShift!;
    }

    startTimeController = TextEditingController(
      text: '00:00',
    );

    endTimeController = TextEditingController(
      text: '00:00',
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CompleteScaffoldWidget(
      appBarTextWidget: Text(
        (workShift.id.isEmpty) ? 'Create work shift' : 'Update work shift',
        style: const TextStyle(color: AppColors.textColor),
      ),
      body: BlocProvider.value(
        value: widget.userAvailableTimeBloc,
        child: BlocListener<UserAvailableTimeBloc, UserAvailableTimeState>(
          listener: (context, state) {
            if (state.postWorkShiftLoadState == LoadState.loaded) {
              Navigator.pop(context, true);
              LoadingDialog.instance.hide();
            }
          },
          child: buildScreen(),
        ),
      ),
      bottomNavigationBar: ButtonWidget(
        title: 'Confirm',
        onPressed: () {
          LoadingDialog.instance.show();
          widget.userAvailableTimeBloc.add(
            PostWorkShift(workShift),
          );
        },
        titleColor: Colors.white,
        backgroundColor: AppColors.accentColor,
      ),
    );
  }

  Widget buildScreen() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.sf, vertical: 12.sf),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sf)
                  .copyWith(bottom: 24.sf),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.dateTime.beautifulDate,
                    style: AppTextStyles.heading3(AppColors.textColor),
                  ),
                  Text(
                    widget.workShiftSession.text,
                    style: AppTextStyles.text(AppColors.textColor),
                  ),
                ],
              ),
            ),
            TextFormFieldWidget(
              onChanged: (_) => workShift.startTime = startTimeController.text
                  .dateTimeFromHourMinute(widget.dateTime),
              controller: startTimeController,
              textInputType: TextInputType.text,
              colorTheme: AppColors.textColor,
              labelText: 'Start time',
            ),
            TextFormFieldWidget(
              onChanged: (_) => workShift.endTime = endTimeController.text
                  .dateTimeFromHourMinute(widget.dateTime),
              controller: endTimeController,
              textInputType: TextInputType.text,
              colorTheme: AppColors.textColor,
              labelText: 'End time',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sf, vertical: 18.sf),
              child: RoundedContainerWidget(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 18.sf),
                      child: Text(
                        'Are you free on this time weekly?',
                        style: AppTextStyles.heading3(AppColors.textColor),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: cycleTimeChanged,
                            builder: (context, value, child) => Flexible(
                              flex: 2,
                              child: ButtonWidget(
                                title: 'No',
                                onPressed: () {
                                  workShift.isCycle = false;
                                  cycleTimeChanged.value =
                                      !cycleTimeChanged.value;
                                },
                                titleColor: (workShift.isCycle == false)
                                    ? AppColors.primaryColor
                                    : AppColors.textColor,
                                backgroundColor: (workShift.isCycle == false)
                                    ? AppColors.accentColor
                                    : AppColors.primaryColor,
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: cycleTimeChanged,
                            builder: (context, value, child) => Flexible(
                              flex: 3,
                              child: ButtonWidget(
                                title: 'Yes',
                                onPressed: () {
                                  workShift.isCycle = true;
                                  cycleTimeChanged.value =
                                      !cycleTimeChanged.value;
                                },
                                titleColor: (workShift.isCycle == true)
                                    ? AppColors.primaryColor
                                    : AppColors.textColor,
                                backgroundColor: (workShift.isCycle == true)
                                    ? AppColors.accentColor
                                    : AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
