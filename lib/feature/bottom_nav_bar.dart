import 'package:eldercare_guardian/core/theme/app_colors.dart';
import 'package:eldercare_guardian/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:eldercare_guardian/feature/report_management/presentation/screens/view_aips_and_report/related_report_info_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';
import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/action_dialog_widget.dart';

import '../core/automatic_generator/assets.gen.dart';
import 'profile/presentation/view_profile/view_profile_screen.dart';
import 'schedule/view_schedule/presentation/schedule_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final bottomNavBarIndex = ValueNotifier<int>(1);
  late PageController _screenController;

  final List<String> screenTitles = [
    'Report',
    'Schedule',
    'Account',
  ];

  late List<Widget> bottomBarScreens = [
    const RelatedReportInfoScreen(),
    const ScheduleScreen(),
    const ViewProfileScreen(),
  ];

  final List<BottomNavigationBarItem> bottomNavigationItems = [
    BottomNavigationBarItem(
      icon: Assets.icons.note.svg(),
      label: 'Report',
    ),
    BottomNavigationBarItem(
      icon: Assets.icons.schedule.svg(),
      label: 'Schedule',
    ),
    BottomNavigationBarItem(
      icon: Assets.icons.user.svg(),
      label: 'Account',
    )
  ];

  @override
  void initState() {
    _screenController = PageController(initialPage: bottomNavBarIndex.value);
    super.initState();
  }

  Future<void> showNotAvailableFeature() async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => ActionDialogWidget(
        isPositiveGradient: true,
        dialogContext: context,
        iconTitle: Icon(
          Icons.policy,
          size: 48.sf,
        ),
        title: 'Our apologize',
        message: 'This feature will be available soon.',
        titleColor: AppColors.textColor,
        positiveActionTitle: 'Never mind',
        onPositiveActionCallback: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: bottomNavBarIndex,
          builder: (context, value, child) => Text(screenTitles[value]),
        ),
        leading: Container(),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textColor,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15.sf),
            child: IconButton(
              onPressed: () {},
              icon: Assets.icons.notification.svg(),
            ),
          ),
        ],
      ),
      extendBody: false,
      body: PageView(
        controller: _screenController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          bottomBarScreens.length,
          (index) => Padding(
            padding: EdgeInsets.only(
              top: 18.sf,
              left: 12.sf,
              right: 12.sf,
            ),
            child: bottomBarScreens[index],
          ),
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: bottomNavBarIndex,
        builder: (context, value, child) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.sf),
              topLeft: Radius.circular(12.sf),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.textColor.withOpacity(0.25.sf),
                spreadRadius: 5.sf,
                blurRadius: 7.sf,
                offset: Offset(0, -1.sf),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.sf),
              topLeft: Radius.circular(15.sf),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              selectedLabelStyle: AppTextStyles.text(
                AppColors.textColor,
                bold: true,
              ),
              unselectedLabelStyle: AppTextStyles.text(AppColors.textColor),
              unselectedItemColor: AppColors.textColor,
              selectedItemColor: AppColors.accentColor,
              items: List.generate(
                bottomNavigationItems.length,
                (index) => bottomNavigationItems[index],
              ),
              currentIndex: bottomNavBarIndex.value,
              onTap: (index) {
                bottomNavBarIndex.value = index;
                _screenController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeIn,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
