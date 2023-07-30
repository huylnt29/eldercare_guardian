import 'package:eldercare_guardian/core/theme/app_colors.dart';
import 'package:eldercare_guardian/core/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';
import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/complete_scaffold_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/tab_bar_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/text_form_field_widget.dart';
import '../bloc/profile_bloc.dart';

part 'tabs/basic_infor_tab.dart';
part 'tabs/education_artifact_tab.dart';
part 'tabs/experience_tab.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 3, vsync: this);
  late List<Widget> tabPages = [];
  final tabTitles = ['Basic info', 'Certification', 'Experience'];

  @override
  void initState() {
    tabPages.addAll(const [
      BasicInforTab(),
      EducationArtifactTab(),
      ExperienceTab(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CompleteScaffoldWidget(
      appBarTextWidget: const Text(
        'Edit profile',
        style: TextStyle(
          color: AppColors.textColor,
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.sf, vertical: 5.sf),
          padding: EdgeInsets.symmetric(horizontal: 16.sf),
          decoration: BoxDecoration(
            color: AppColors.accentColor,
            borderRadius: BorderRadius.circular(16.sf),
          ),
          child: Center(
            child: Text(
              'Confirm',
              style: AppTextStyles.text(Colors.white, bold: true),
            ),
          ),
        ),
      ],
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.tempProfile != null) {
            return Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    state.profile!.avatar ??
                        'https://ui-avatars.com/api/?name=${state.tempProfile!.firstName}',
                  ),
                  radius: 45.sf,
                ),
                12.vSpace,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.sf),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(18.sf),
                  ),
                  child: Center(
                    child: TabBarWidget(
                      tabController: tabController,
                      tabs: tabTitles,
                      selectedGradientBackgroundColor: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          AppColors.accentColor,
                          AppColors.secondaryColor
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 18.sf),
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: tabPages,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const AppErrorWidget();
          }
        },
      ),
    );
  }
}
