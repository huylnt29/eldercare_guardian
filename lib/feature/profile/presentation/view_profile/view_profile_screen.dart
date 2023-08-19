import 'package:eldercare_guardian/core/extensions/string_extension.dart';
import 'package:eldercare_guardian/core/faked/faked_data.dart';
import 'package:eldercare_guardian/core/model/profile_model.dart';
import 'package:eldercare_guardian/core/router/route_config.dart';
import 'package:eldercare_guardian/core/router/route_paths.dart';
import 'package:eldercare_guardian/core/theme/app_colors.dart';
import 'package:eldercare_guardian/core/widgets/error_widget.dart';
import 'package:eldercare_guardian/core/widgets/no_data_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huylnt_flutter_component/reusable_core/constants/error_message.dart';
import 'package:huylnt_flutter_component/reusable_core/enums/load_state.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/date_time.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';
import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/button_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/cached_network_image_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/home_shimmer.dart';

import '../bloc/profile_bloc.dart';
import 'widgets/education_artifact_item.dart';
import 'widgets/experience_item.dart';
import 'widgets/profile_basic_info_item.dart';

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>()
      ..add(FetchDataForScreenEvent());

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.profileUpdatedSuccessfully == true) {
          profileBloc.add(FetchDataForScreenEvent());
        }
      },
      builder: (context, state) {
        if (state.loadState == LoadState.loaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetWorkImageWidget(
                        imageUrl: state.profile!.avatar ??
                            '${FakedData.uiAvatarPath}${state.profile!.lastName}',
                      ),
                    ),
                    12.hSpace,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.sf,
                        vertical: 8.sf,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.textColor.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(24.sf),
                      ),
                      child: Text(
                        state.profile!.level.text,
                        style: AppTextStyles.text(
                          AppColors.secondaryColor,
                          bold: true,
                        ),
                      ),
                    )
                  ],
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
                      state.profile!.dateOfBirth?.toDateTime.beautifulDate ??
                          ErrorMessage.isNotDetermined,
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
                  physics: const NeverScrollableScrollPhysics(),
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
                  physics: const NeverScrollableScrollPhysics(),
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
