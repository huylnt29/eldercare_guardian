import 'package:eldercare_guardian/core/router/route_config.dart';
import 'package:eldercare_guardian/core/router/route_paths.dart';
import 'package:eldercare_guardian/core/theme/app_colors.dart';
import 'package:eldercare_guardian/core/widgets/error_widget.dart';
import 'package:eldercare_guardian/core/widgets/no_data_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huylnt_flutter_component/reusable_core/enums/load_state.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';
import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/button_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/home_shimmer.dart';

import '../bloc/profile_bloc.dart';
import 'widgets/education_artifact_item.dart';
import 'widgets/experience_item.dart';
import 'widgets/profile_basic_info_item.dart';

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.profileUpdatedSuccessfully == true) {
          context.read<ProfileBloc>().add(FetchDataForScreenEvent());
        }
      },
      builder: (context, state) {
        if (state.loadState == LoadState.loaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    state.profile!.avatar ??
                        'https://ui-avatars.com/api/?name=${state.profile!.firstName}',
                  ),
                  radius: 45.sf,
                ),
                12.vSpace,
                Column(
                  children: [
                    ProfileBasicInfoItem(
                      'First name',
                      state.profile!.firstName,
                    ),
                    ProfileBasicInfoItem(
                      'Last name',
                      state.profile!.lastName,
                    ),
                    ProfileBasicInfoItem(
                      'Date of birth',
                      state.profile!.dateOfBirth,
                    ),
                    ProfileBasicInfoItem(
                      'Identity number',
                      state.profile!.identity,
                    ),
                    ProfileBasicInfoItem(
                      'Email',
                      state.profile!.email,
                    ),
                    ProfileBasicInfoItem(
                      'Phone number',
                      state.profile!.phoneNumber,
                    ),
                    ProfileBasicInfoItem(
                      'Address',
                      state.profile!.address,
                    ),
                    buildEducationArtifactArea(state),
                    buildExperienceArea(state),
                  ],
                ),
                ButtonWidget(
                  title: 'Edit profile',
                  onPressed: () => Routes.router.navigateTo(
                    context,
                    RoutePath.editProfileScreen,
                  ),
                  backgroundColor: AppColors.accentColor,
                ),
              ],
            ),
          );
        } else if (state.loadState == LoadState.loading) {
          return const HomeShimmer();
        } else {
          return const AppErrorWidget();
        }
      },
    );
  }

  Container buildExperienceArea(ProfileState state) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.sf),
      padding: EdgeInsets.symmetric(vertical: 12.sf, horizontal: 12.sf),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(18.sf),
      ),
      child: Column(
        children: [
          Text(
            'Experience(s)',
            style: AppTextStyles.heading2(AppColors.textColor),
          ),
          (state.profile!.experiences.isNotEmpty)
              ? ListView(
                  shrinkWrap: true,
                  children: [
                    for (var experience in state.profile!.experiences)
                      ExperienceItem(
                        experience!.position!,
                        experience.description,
                        experience.startDate,
                        experience.endDate,
                      ),
                  ],
                )
              : const NoDataWidget(),
        ],
      ),
    );
  }

  Container buildEducationArtifactArea(ProfileState state) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.sf),
      padding: EdgeInsets.symmetric(vertical: 12.sf, horizontal: 12.sf),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(18.sf),
      ),
      child: Column(
        children: [
          Text(
            'Degree/Certificate(s)',
            style: AppTextStyles.heading2(AppColors.textColor),
          ),
          (state.profile!.educationArtifacts.isNotEmpty)
              ? ListView(
                  shrinkWrap: true,
                  children: [
                    for (var educationArtifact
                        in state.profile!.educationArtifacts)
                      EducationArtifactItem(
                        educationArtifact!.title!,
                        educationArtifact.description,
                        educationArtifact.imageEvidence,
                      ),
                  ],
                )
              : const NoDataWidget(),
        ],
      ),
    );
  }
}
