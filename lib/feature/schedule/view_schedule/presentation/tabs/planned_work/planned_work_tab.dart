part of '../../schedule_screen.dart';

class PlannedWorkTab extends StatelessWidget {
  const PlannedWorkTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PlannedWorkBloc>()..add(InitScreenEvent()),
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
