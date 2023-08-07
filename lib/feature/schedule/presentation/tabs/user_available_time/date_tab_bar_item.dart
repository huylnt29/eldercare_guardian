part of '../../schedule_screen.dart';

class DateTabBarItem extends StatelessWidget {
  const DateTabBarItem({
    required this.dateTime,
    required this.isSelected,
    super.key,
  });

  final DateTime dateTime;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return RoundedContainerWidget(
        child: Column(
      children: [
        Flexible(
          flex: 2,
          child: Text(dateTime.day.toString()),
        ),
        Flexible(
          flex: 1,
          child: Container(
            color:
                (isSelected) ? AppColors.accentColor : AppColors.secondaryColor,
            child: Text(
              DateTimeConverter.getWeekDay(dateTime.millisecondsSinceEpoch),
            ),
          ),
        ),
      ],
    ));
  }
}
