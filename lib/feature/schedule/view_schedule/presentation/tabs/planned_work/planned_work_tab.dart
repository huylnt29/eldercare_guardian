part of '../../schedule_screen.dart';

class PlannedWorkTab extends StatefulWidget {
  const PlannedWorkTab({super.key});

  @override
  State<PlannedWorkTab> createState() => _PlannedWorkTabState();
}

class _PlannedWorkTabState extends State<PlannedWorkTab> {
  final plannedWorkBloc = getIt<PlannedWorkBloc>()..add(InitScreenEvent());
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
