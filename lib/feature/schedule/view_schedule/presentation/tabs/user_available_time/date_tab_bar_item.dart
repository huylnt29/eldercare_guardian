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
    return Container(
      width: 150.sf,
      margin: EdgeInsets.only(right: 18.sf),
      child: RoundedContainerWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(dateTime.day.toString()),
            Text(
              dateTime.weekDay,
              style: AppTextStyles.text(
                isSelected ? AppColors.accentColor : AppColors.textColor,
                bold: isSelected ? true : false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
