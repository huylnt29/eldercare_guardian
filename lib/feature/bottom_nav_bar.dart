import 'package:eldercare_guardian/core/extensions/font_size_extensions.dart';
import 'package:eldercare_guardian/core/theme/app_colors.dart';
import 'package:eldercare_guardian/core/theme/app_text_styles.dart';
import 'package:eldercare_guardian/feature/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:eldercare_guardian/feature/schedule/presentation/schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/automatic_generator/assets.gen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final bottomNavBarIndex = ValueNotifier<int>(1);
  late PageController _screenController;

  final List<String> screenTitles = [
    'AIPs',
    'Schedule',
    'Report',
    'Account',
  ];

  late List<Widget> bottomBarScreens = [
    const Text('AIPs'),
    BlocProvider.value(
      value: BlocProvider.of<ScheduleBloc>(context)..add(InitScreenEvent()),
      child: const ScheduleScreen(),
    ),
    const Text('Report'),
    const Text('Account'),
  ];

  final List<BottomNavigationBarItem> bottomNavigationItems = [
    BottomNavigationBarItem(
      icon: Assets.icons.aips.svg(),
      label: 'AIPs',
    ),
    BottomNavigationBarItem(
      icon: Assets.icons.schedule.svg(),
      label: 'Schedule',
    ),
    BottomNavigationBarItem(
      icon: Assets.icons.note.svg(),
      label: 'Report',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: bottomNavBarIndex,
          builder: (context, value, child) => Text(screenTitles[value]),
        ),
        leading: Container(),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.textColor,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.sf),
            child: Assets.icons.notification.svg(),
          )
        ],
      ),
      extendBody: true,
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
              topRight: Radius.circular(24.sf),
              topLeft: Radius.circular(24.sf),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.textColor.withOpacity(0.3),
                spreadRadius: 5.sf,
                blurRadius: 7.sf,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.sf),
              topLeft: Radius.circular(15.sf),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
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
