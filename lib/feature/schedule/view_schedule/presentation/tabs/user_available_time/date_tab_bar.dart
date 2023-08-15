part of '../../schedule_screen.dart';

class DateTabBar extends StatefulWidget {
  const DateTabBar({
    Key? key,
    required this.weekDateTimes,
    required this.tabController,
  }) : super(key: key);

  final List<DateTime> weekDateTimes;
  final TabController tabController;

  @override
  State<DateTabBar> createState() => _DateTabBarState();
}

class _DateTabBarState extends State<DateTabBar> {
  int _currentIndex = 0;
  final activeDateTabBarIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {
      if (_currentIndex != widget.tabController.index) {
        setState(() => _currentIndex = widget.tabController.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          7,
          (index) => InkWell(
            child: buildTab(index),
            onTap: () => widget.tabController.animateTo(index),
          ),
        ),
      ),
    );
  }

  Widget buildTab(int index) {
    final isSelected = (widget.tabController.index == index);
    final item = widget.weekDateTimes[index];
    return DateTabBarItem(
      dateTime: item,
      isSelected: isSelected,
    );
  }
}

class LoadingDateTabBar extends StatelessWidget {
  const LoadingDateTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
