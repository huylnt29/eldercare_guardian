part of '../../schedule_screen.dart';

class DateTabBar extends StatefulWidget {
  const DateTabBar({
    Key? key,
    this.height,
    this.width,
    required this.timeRange,
    required this.weekDateTimes,
    required this.tabController,
  }) : super(key: key);

  final double? height;
  final double? width;
  final String timeRange;
  final List<DateTime> weekDateTimes;
  final TabController tabController;

  @override
  State<DateTabBar> createState() => _DateTabBarState();
}

class _DateTabBarState extends State<DateTabBar> {
  int _currentIndex = 0;

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
    return Column(
      children: [
        Text(
          widget.timeRange,
          style: AppTextStyles.heading3(AppColors.textColor),
        ),
        5.vSpace,
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: false,
          scrollDirection: Axis.horizontal,
          itemCount: widget.weekDateTimes.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              widget.tabController.animateTo(index);
              setState(() {});
            },
            child: _buildTab(index),
          ),
        ),
      ],
    );
  }

  Widget _buildTab(int index) {
    final isSelected = (widget.tabController.index == index);
    final item = widget.weekDateTimes[index];
    return DateTabBarItem(
      dateTime: item,
      isSelected: isSelected,
    );
  }
}
