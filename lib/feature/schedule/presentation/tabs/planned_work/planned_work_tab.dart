part of '../../schedule_screen.dart';

class PlannedWorkTab extends StatelessWidget {
  PlannedWorkTab({super.key});
  final plannedWorkBloc = PlannedWorkBloc(
    ScheduleRepositoryImpl(
      ScheduleRemoteDataSource(getIt()),
    ),
  )..add(InitScreenEvent());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => plannedWorkBloc,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const FilteringArea(),
            32.vSpace,
            const TaskListArea(),
          ],
        ),
      ),
    );
  }
}
