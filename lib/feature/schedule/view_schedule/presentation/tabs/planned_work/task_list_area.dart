part of '../../schedule_screen.dart';

class TaskListArea extends StatefulWidget {
  const TaskListArea({super.key});

  @override
  State<TaskListArea> createState() => _TaskListAreaState();
}

class _TaskListAreaState extends State<TaskListArea> {
  late PlannedWorkBloc plannedWorkBloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    plannedWorkBloc = context.read<PlannedWorkBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlannedWorkBloc, PlannedWorkState>(
        listener: (context, state) {
      if (state.loadState == LoadState.loading) {
        LoadingDialog.instance.show();
      } else if (state.loadState == LoadState.loaded) {
        LoadingDialog.instance.hide();
      }
    }, builder: (context, state) {
      if (state.loadState == LoadState.loaded) {
        if (state.tasks.isNotEmpty) {
          return Container(
            margin: EdgeInsets.only(bottom: 24.sf),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  taskListItem(state.tasks[index]!),
              separatorBuilder: (context, index) => 15.vSpace,
              itemCount: state.tasks.length,
            ),
          );
        } else {
          return const NoDataWidget();
        }
      } else if (state.loadState == LoadState.loading) {
        return Container();
      } else {
        return const AppErrorWidget();
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
              vertical: 5.sf,
              horizontal: 8.sf,
            ).copyWith(left: 8.sf, top: 12.sf),
            margin: EdgeInsets.only(bottom: 3.sf),
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
                    Expanded(
                      child: Text(
                        task.title,
                        style: AppTextStyles.heading3(AppColors.textColor),
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    8.hSpace,
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
                  child: CachedNetWorkImageWidget(
                    imageUrl: task.taskEvidence!.imageEvidencePath,
                    fit: BoxFit.cover,
                    width: 61.sf,
                    height: 61.sf,
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
                ),
              ),
      ],
    );
  }

  Future<void> onNavigatingTakePictureScreen(String taskId) async {
    final xFile = await Routes.router.navigateTo(
      context,
      RoutePath.takePictureScreen,
      routeSettings: RouteSettings(
        arguments: {
          'artifactId': taskId,
          'takePictureScreenPurpose': TakePictureScreenPurpose.postTaskEvidence,
        },
      ),
    );

    Logger.v('Received xFile which is task evidence: ');
    Logger.d(xFile);

    if (xFile != null) {
      plannedWorkBloc.add(PostTaskEvidenceEvent(taskId, xFile));
    }
  }
}
