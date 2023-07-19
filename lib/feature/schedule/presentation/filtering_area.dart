part of './schedule_screen.dart';

class FilteringArea extends StatefulWidget {
  const FilteringArea({super.key});

  @override
  State<FilteringArea> createState() => _FilteringAreaState();
}

class _FilteringAreaState extends State<FilteringArea> {
  late ScheduleBloc scheduleBloc;
  @override
  void initState() {
    scheduleBloc = context.read<ScheduleBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10.sf,
        left: 18.sf,
        right: 18.sf,
        bottom: 24.sf,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.sf),
        boxShadow: [
          BoxShadow(
            color: AppColors.textColor.withOpacity(0.5),
            spreadRadius: 1.sf,
            blurRadius: 5.sf,
          )
        ],
      ),
      child: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Schedule of: ',
                style: AppTextStyles.heading1(AppColors.textColor),
              ),
              12.vSpace,
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 12.sf,
                  horizontal: 20.sf,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.sf,
                    color: AppColors.paleSilverBackgroundColor,
                  ),
                  borderRadius: BorderRadius.circular(18.sf),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => scheduleBloc.add(
                        ChangeDateTimeEvent(
                          state.currentSelectedDate.subtract(
                            const Duration(days: 1),
                          ),
                        ),
                      ),
                      child: Assets.icons.arrowLeft.svg(),
                    ),
                    Text(
                      DateTimeConverter.getDateInSchedule(
                        state.currentSelectedDate.millisecondsSinceEpoch,
                      ),
                      style: AppTextStyles.text(
                        AppColors.accentColor,
                        bold: true,
                      ),
                    ),
                    InkWell(
                      onTap: () => scheduleBloc.add(
                        ChangeDateTimeEvent(
                          state.currentSelectedDate.add(
                            const Duration(days: 1),
                          ),
                        ),
                      ),
                      child: Transform.flip(
                        flipX: true,
                        child: Assets.icons.arrowLeft.svg(),
                      ),
                    ),
                  ],
                ),
              ),
              10.vSpace,
              Text(
                'For AIP(s): ',
                style: AppTextStyles.heading1(AppColors.textColor),
              ),
              10.vSpace,
              (state.loadState == LoadState.loaded)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              hint: const Text('Select an AIP'),
                              items: List.from(state.aips
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e!.id,
                                      child: Text(e.lastName),
                                    ),
                                  )
                                  .toList())
                                ..add(
                                  const DropdownMenuItem(
                                    value: null,
                                    child: Text('All'),
                                  ),
                                ),
                              isExpanded: true,
                              value: (state.aipId != null)
                                  ? state.aips
                                      .firstWhere((element) =>
                                          (element != null) &&
                                          element.id == state.aipId)!
                                      .id
                                  : null,
                              onChanged: (value) => scheduleBloc.add(
                                ChangeAipEvent(value as String?),
                              ),
                              buttonStyleData: ButtonStyleData(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.sf),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2.sf,
                                    color: AppColors.paleSilverBackgroundColor,
                                  ),
                                  borderRadius: BorderRadius.circular(18.sf),
                                ),
                                height: 40.sf,
                              ),
                              menuItemStyleData: MenuItemStyleData(
                                height: 40.sf,
                              ),
                            ),
                          ),
                        ),
                        10.hSpace,
                        Visibility(
                          visible: (state.aipId != null),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 5.sf,
                              horizontal: 12.sf,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accentColor,
                              borderRadius: BorderRadius.circular(12.sf),
                            ),
                            child: Text(
                              'View profile',
                              style: AppTextStyles.heading3(Colors.white),
                            ),
                          ),
                        )
                      ],
                    )
                  : const Text('Loading'),
            ],
          );
        },
      ),
    );
  }
}
