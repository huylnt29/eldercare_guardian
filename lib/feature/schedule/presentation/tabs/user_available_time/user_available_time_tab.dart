part of '../../schedule_screen.dart';

class UserAvailableTimeTab extends StatefulWidget {
  const UserAvailableTimeTab({super.key});

  @override
  State<UserAvailableTimeTab> createState() => _UserAvailableTimeTabState();
}

class _UserAvailableTimeTabState extends State<UserAvailableTimeTab>
    with TickerProviderStateMixin {
  final plannedWorkBloc = PlannedWorkBloc(
    ScheduleRepositoryImpl(
      ScheduleRemoteDataSource(getIt()),
    ),
  )..add(InitScreenEvent());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => plannedWorkBloc,
      child: buildContent(),
    );
  }

  Widget buildContent() {
    return Container();
  }
}
