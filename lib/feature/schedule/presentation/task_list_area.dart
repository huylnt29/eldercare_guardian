part of 'schedule_screen.dart';

class TaskListArea extends StatefulWidget {
  const TaskListArea({super.key});

  @override
  State<TaskListArea> createState() => _TaskListAreaState();
}

class _TaskListAreaState extends State<TaskListArea> {
  late ScheduleBloc scheduleBloc;
  @override
  void initState() {
    scheduleBloc = context.read<ScheduleBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(builder: (context, state) {
      if (state.loadState == LoadState.loaded) {
        return ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => taskListItem(state.tasks[index]!),
          separatorBuilder: (context, index) => 15.vSpace,
          itemCount: state.tasks.length,
        );
      } else {
        return const ListViewShimmer();
      }
    });
  }

  Widget taskListItem(Task task) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 12.sf,
              horizontal: 8.sf,
            ).copyWith(left: 10.sf),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.sf,
                color: AppColors.getColorBasedOnTaskDoneOrNot(task.isDone),
              ),
              borderRadius: BorderRadius.circular(18.sf),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: AppTextStyles.heading2(AppColors.textColor),
                    ),
                    12.hSpace,
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.sf,
                        horizontal: 8.sf,
                      ),
                      decoration: BoxDecoration(
                        color:
                            AppColors.getColorBasedOnTaskDoneOrNot(task.isDone),
                        borderRadius: BorderRadius.circular(18.sf),
                      ),
                      child: Text(
                        (task.isDone) ? 'Done' : 'Not done',
                        softWrap: true,
                        style: AppTextStyles.text(
                          Colors.white,
                          bold: true,
                        ),
                      ),
                    )
                  ],
                ),
                8.vSpace,
                Visibility(
                  visible: task.aipName != null,
                  child: Text(
                    task.aipName ?? ErrorMessage.isNotDetermined,
                    style: AppTextStyles.heading3(AppColors.textColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        18.hSpace,
        (task.taskEvidence != null)
            ? InkWell(
                // TODO: Remove when done testing
                onTap: () => onNavigatingTakePictureScreen(task.id),
                child: ClipOval(
                  child: Image.network(
                    task.taskEvidence!.imageEvidencePath,
                    width: 50.sf,
                    height: 50.sf,
                    fit: BoxFit.cover,
                    errorBuilder: (context, exception, stackTrace) {
                      return Assets.images.emptyImage.image();
                    },
                  ),
                ),
              )
            : Container(
                padding: EdgeInsets.all(7.sf),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.sf),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  onPressed: () => onNavigatingTakePictureScreen(task.id),
                  icon: Assets.icons.camera.svg(),
                  iconSize: 30.sf,
                ),
              ),
      ],
    );
  }

  Future<void> onNavigatingTakePictureScreen(String taskId) async {
    final postedTaskEvidenceSuccessfully = await Routes.router.navigateTo(
      context,
      RoutePath.takePictureScreen,
      routeSettings: RouteSettings(
        arguments: taskId,
      ),
    );
    if (postedTaskEvidenceSuccessfully == true) {
      ToastWidget.show('Posted task evidence successfully');
      scheduleBloc.add(InitScreenEvent());
    } else if (postedTaskEvidenceSuccessfully == false) {
      ToastWidget.show('Try again later.');
      scheduleBloc.add(StateLoadedEvent());
    } else {
      scheduleBloc.add(StateLoadedEvent());
    }
  }
}
