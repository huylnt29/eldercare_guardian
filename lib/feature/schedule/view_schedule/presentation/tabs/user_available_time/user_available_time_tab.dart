part of '../../schedule_screen.dart';

class UserAvailableTimeTab extends StatefulWidget {
  const UserAvailableTimeTab({super.key});

  @override
  State<UserAvailableTimeTab> createState() => _UserAvailableTimeTabState();
}

class _UserAvailableTimeTabState extends State<UserAvailableTimeTab>
    with TickerProviderStateMixin {
  final userAvailableTimeBloc = getIt<UserAvailableTimeBloc>()
    ..add(
      FetchDayWorkShift(DateTime.now().firstDayOfNextWeek),
    );

  late final tabController = TabController(length: 7, vsync: this);

  @override
  void initState() {
    super.initState();
    tabController.addListener(() {
      userAvailableTimeBloc.add(
        FetchDayWorkShift(
          userAvailableTimeBloc.state.weekDates[tabController.index],
        ),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showPolicyDialog();
    });
  }

  @override
  void dispose() {
    // tabController.dispose();
    super.dispose();
  }

  Future<void> showPolicyDialog() async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => ActionDialogWidget(
        isPositiveGradient: true,
        dialogContext: context,
        iconTitle: Icon(
          Icons.policy,
          size: 48.sf,
        ),
        title: 'Policy of picking available time',
        message: 'You can only edit your available time before Saturday.',
        titleColor: AppColors.textColor,
        positiveActionTitle: 'Understand',
        onPositiveActionCallback: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: userAvailableTimeBloc,
      child: buildContent(),
    );
  }

  Widget buildContent() {
    return BlocBuilder<UserAvailableTimeBloc, UserAvailableTimeState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            8.vSpace,
            buildTabBar(state),
            18.vSpace,
            Expanded(child: buildDayWorkShiftDisplay(state)),
          ],
        );
      },
    );
  }

  Widget buildTabBar(UserAvailableTimeState state) {
    return DateTabBar(
      weekDateTimes: state.weekDates,
      tabController: tabController,
    );
  }

  Widget buildDayWorkShiftDisplay(UserAvailableTimeState state) {
    if (state.loadState == LoadState.loaded) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildSessionWorkShiftBox(
              state.currentSelectedDate,
              WorkShiftSession.morning,
              state.dayWorkShift!.morningShifts,
            ),
            24.vSpace,
            buildSessionWorkShiftBox(
              state.currentSelectedDate,
              WorkShiftSession.afternoon,
              state.dayWorkShift!.afternoonShifts,
            ),
            24.vSpace,
            buildSessionWorkShiftBox(
              state.currentSelectedDate,
              WorkShiftSession.evening,
              state.dayWorkShift!.eveningShifts,
            ),
            36.vSpace,
          ],
        ),
      );
    } else if (state.loadState == LoadState.error) {
      return const AppErrorWidget();
    }
    return const ListViewShimmer();
  }

  Widget buildSessionWorkShiftBox(
    DateTime dateTime,
    WorkShiftSession workShiftSession,
    List<WorkShift> workShifts,
  ) {
    return RoundedContainerWidget(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 300.sf,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 12.sf),
              decoration: BoxDecoration(
                color: AppColors.textColor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12.sf),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    workShiftSession.text,
                    style: AppTextStyles.heading3(
                      AppColors.secondaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final result = await Routes.router.navigateTo(
                        context,
                        RoutePath.editWorkShiftScreen,
                        routeSettings: RouteSettings(
                          arguments: {
                            'userAvailableTimeBloc': userAvailableTimeBloc,
                            'dateTime': dateTime,
                            'workShiftSession': workShiftSession,
                          },
                        ),
                      );
                      if (result == true) {
                        userAvailableTimeBloc.add(
                          FetchDayWorkShift(
                            userAvailableTimeBloc.state.currentSelectedDate,
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            8.vSpace,
            (workShifts.isNotEmpty)
                ? ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => buildWorkShiftItem(
                      workShifts[index],
                    ),
                    separatorBuilder: (context, index) => 1.vSpace,
                    itemCount: workShifts.length,
                  )
                : const NoDataWidget(),
          ],
        ),
      ),
    );
  }

  Widget buildWorkShiftItem(WorkShift workShift) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.sf),
      child: InkWell(
        onLongPress: () => userAvailableTimeBloc.add(
          DeleteWorkShift(workShift),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              workShift.startTime.hourMinute,
              style: AppTextStyles.text(AppColors.textColor),
            ),
            Icon(
              Icons.arrow_right_alt_outlined,
              size: 48.sf,
            ),
            Text(
              workShift.endTime.hourMinute,
              style: AppTextStyles.text(AppColors.textColor),
            ),
          ],
        ),
      ),
    );
  }
}
