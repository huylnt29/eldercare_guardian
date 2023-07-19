import 'package:eldercare_guardian/core/extensions/font_size_extensions.dart';
import 'package:eldercare_guardian/core/service_locator/service_locator.dart';
import 'package:eldercare_guardian/core/theme/app_colors.dart';
import 'package:eldercare_guardian/core/theme/app_text_styles.dart';
import 'package:eldercare_guardian/feature/authentication/presentation/sign_in/presentation/sign_in_screen.dart';
import 'package:eldercare_guardian/feature/schedule/data/repository/schedule_repository_impl.dart';
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
  final bottomNavBarIndex = ValueNotifier<int>(2);
  late PageController _screenController;

  final List<String> screenTitles = [
    'AIPs',
    'Account',
    'Schedule',
  ];

  late List<Widget> bottomBarScreens = [
    const Text('AIPs'),
    const Text('Account'),
    BlocProvider.value(
      value: BlocProvider.of<ScheduleBloc>(context)..add(InitScreenEvent()),
      child: const ScheduleScreen(),
    ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          bottomNavBarIndex.value = screenTitles.length - 1;
          _screenController.animateToPage(
            screenTitles.length - 1,
            duration: const Duration(seconds: 1),
            curve: Curves.easeIn,
          );
        },
        tooltip: 'Schedule',
        child: Assets.icons.schedule.svg(),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          selectedItemColor: AppColors.accentColor,
          backgroundColor: AppColors.primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Assets.icons.aips.svg(),
              label: 'AIPs',
            ),
            BottomNavigationBarItem(
              icon: Assets.icons.user.svg(),
              label: 'Account',
            )
          ],
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
    );
  }
}
