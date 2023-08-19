import 'dart:io';

import 'package:eldercare_guardian/core/automatic_generator/assets.gen.dart';
import 'package:eldercare_guardian/core/extensions/string_extension.dart';
import 'package:eldercare_guardian/core/faked/faked_data.dart';
import 'package:eldercare_guardian/core/theme/app_colors.dart';
import 'package:eldercare_guardian/core/widgets/error_widget.dart';
import 'package:eldercare_guardian/feature/profile/data/model/education_artifact_model.dart';
import 'package:eldercare_guardian/feature/profile/data/model/experience_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huylnt_flutter_component/reusable_core/constants/error_message.dart';

import 'package:huylnt_flutter_component/reusable_core/enums/load_state.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/date_time.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';

import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/action_dialog_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/button_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/cached_network_image_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/complete_scaffold_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/tab_bar_text.dart';

import 'package:huylnt_flutter_component/reusable_core/widgets/rounded_container_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/text_form_field_widget.dart';
import '../../../../core/router/route_config.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../core/widgets/loading_dialog.dart';
import '../../../photo_capture/presentation/take_picture_screen.dart';
import '../bloc/profile_bloc.dart';

part 'tabs/profile_basic_infor_tab.dart';
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
      ProfileBasicInfoTab(),
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
      onLeadingPressed: () {
        showDialog<void>(
          context: context,
          builder: (ctx) => ActionDialogWidget(
            isPositiveGradient: true,
            dialogContext: context,
            iconTitle: const Icon(Icons.warning_amber_rounded),
            title: 'Confirm navigation',
            titleColor: AppColors.textColor,
            displayCloseButton: true,
            positiveActionTitle: 'OK',
            negativeActionTitle: 'Stay',
            negativeBtnBorderColor: AppColors.disableBackgroundColor,
            negativeBtnTextColor: AppColors.textColor,
            onPositiveActionCallback: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            message: 'If you navigate back, some changes will be lost.',
          ),
        );
      },
      actions: [
        InkWell(
          onTap: () {
            context.read<ProfileBloc>().add(UpdateProfileEvent());
            LoadingDialog.instance.show();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.sf, vertical: 5.sf)
                .copyWith(right: 12.sf),
            padding: EdgeInsets.symmetric(horizontal: 12.sf),
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
        ),
      ],
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.profileUpdatedSuccessfully == true) {
            Navigator.of(context).pop();
            LoadingDialog.instance.hide();
          }
        },
        builder: (context, state) {
          if (state.loadState == LoadState.error) {
            LoadingDialog.instance.hide();
            return const AppErrorWidget();
          } else if (state.tempProfile != null) {
            return Column(
              children: [
                8.vSpace,
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetWorkImageWidget(
                    imageUrl: state.profile!.avatar ??
                        '${FakedData.uiAvatarPath}${state.profile!.lastName}',
                  ),
                ),
                18.vSpace,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 18.sf),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(18.sf),
                  ),
                  child: TabBarText(
                    tabController: tabController,
                    tabs: tabTitles,
                    selectedGradientBackgroundColor: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomLeft,
                      colors: [
                        AppColors.textColor,
                        AppColors.secondaryColor.withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 18.sf,
                      horizontal: 18.sf,
                    ),
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
            return Container();
          }
        },
      ),
    );
  }
}
