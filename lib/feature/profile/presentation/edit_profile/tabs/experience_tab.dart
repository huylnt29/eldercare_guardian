part of '../edit_profile_screen.dart';

class ExperienceTab extends StatefulWidget {
  const ExperienceTab({super.key});

  @override
  State<ExperienceTab> createState() => _ExperienceTabState();
}

class _ExperienceTabState extends State<ExperienceTab> {
  late ProfileBloc profileBloc;
  final keyboardInvisible = ValueNotifier(true);
  @override
  void initState() {
    super.initState();
    profileBloc = context.read<ProfileBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => buildExperienceItem(
                  profileBloc.state.tempProfile!.experiences[index]!,
                ),
                separatorBuilder: (context, index) => 24.vSpace,
                itemCount: profileBloc.state.tempProfile!.experiences.length,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: keyboardInvisible,
              builder: (context, value, _) {
                if (value) {
                  return ButtonWidget(
                    title: 'Add more',
                    onPressed: () => profileBloc.add(AddMoreExperience()),
                    backgroundColor: AppColors.accentColor,
                    margin: EdgeInsets.symmetric(vertical: 2.sf),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildExperienceItem(Experience experience) {
    final positionController = TextEditingController(
        text: experience.position ?? ErrorMessage.isNotDetermined);
    final descriptionController = TextEditingController(
        text: experience.description ?? ErrorMessage.isNotDetermined);
    final startDateController = ValueNotifier(
      experience.startDate.beautifulDate,
    );
    final endDateController = ValueNotifier(
      experience.endDate.beautifulDate,
    );
    return InkWell(
      onLongPress: () {
        showDialog<void>(
          context: context,
          builder: (ctx) => ActionDialogWidget(
            isPositiveGradient: true,
            dialogContext: context,
            iconTitle: const Icon(Icons.warning_amber_rounded),
            title: 'Confirm deletion',
            titleColor: AppColors.textColor,
            displayCloseButton: true,
            positiveActionTitle: 'Yes',
            negativeActionTitle: 'Cancel',
            negativeBtnBorderColor: AppColors.disableBackgroundColor,
            negativeBtnTextColor: AppColors.textColor,
            onPositiveActionCallback: () {
              profileBloc.add(
                DeleteExperience(experience),
              );
              Navigator.of(context).pop();
            },
            message: 'Do you want to delete this experience record?',
          ),
        );
      },
      child: SizedBox(
        height: 275.sf,
        child: RoundedContainerWidget(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.sf,
                      vertical: 6.sf,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(24.sf),
                    ),
                    child: InkWell(
                      onTap: () => selectDate(
                        experience,
                        startDateController,
                        ExperienceDatePickerPurpose.startDate,
                      ),
                      child: ValueListenableBuilder(
                        valueListenable: startDateController,
                        builder: (context, value, child) => Text(value),
                      ),
                    ),
                  ),
                  8.horizontal,
                  Expanded(
                    child: Transform.rotate(
                      angle: 1.57,
                      child: Assets.images.timelineProgress.image(),
                    ),
                  ),
                  8.horizontal,
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.sf,
                      vertical: 6.sf,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(24.sf),
                    ),
                    child: InkWell(
                      onTap: () => selectDate(
                        experience,
                        endDateController,
                        ExperienceDatePickerPurpose.endDate,
                      ),
                      child: ValueListenableBuilder(
                        valueListenable: endDateController,
                        builder: (context, value, child) => Text(value),
                      ),
                    ),
                  ),
                ],
              ),
              18.vSpace,
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.sf,
                    vertical: 5.sf,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(18.sf),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: TextFormFieldWidget(
                          onEditingComplete: () {
                            keyboardInvisible.value = true;
                            FocusScope.of(context).unfocus();
                          },
                          onTap: () => keyboardInvisible.value = false,
                          onTapOutside: (_) {
                            keyboardInvisible.value = true;
                            FocusScope.of(context).unfocus();
                          },
                          onChanged: (_) {
                            experience.position = positionController.text;
                            if (experience.editionType ==
                                ExperienceEditionType.original) {
                              experience.editionType =
                                  ExperienceEditionType.originalModified;
                            }
                          },
                          controller: positionController,
                          textInputType: TextInputType.name,
                          colorTheme: AppColors.textColor,
                          labelText: 'Position',
                        ),
                      ),
                      12.vSpace,
                      Flexible(
                        child: TextFormFieldWidget(
                          onEditingComplete: () {
                            keyboardInvisible.value = true;
                            FocusScope.of(context).unfocus();
                          },
                          onTap: () => keyboardInvisible.value = false,
                          onTapOutside: (_) {
                            keyboardInvisible.value = true;
                            FocusScope.of(context).unfocus();
                          },
                          onChanged: (_) {
                            experience.description = descriptionController.text;
                            if (experience.editionType ==
                                ExperienceEditionType.original) {
                              experience.editionType =
                                  ExperienceEditionType.originalModified;
                            }
                          },
                          controller: descriptionController,
                          textInputType: TextInputType.name,
                          colorTheme: AppColors.textColor,
                          labelText: 'Description',
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> selectDate(
    Experience experience,
    ValueNotifier valueNotifier,
    ExperienceDatePickerPurpose experienceDatePickerPurpose,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      valueNotifier.value = picked.beautifulDate;
      if (experienceDatePickerPurpose ==
          ExperienceDatePickerPurpose.startDate) {
        experience.startDate = picked;
      } else {
        experience.endDate = picked;
      }
      if (experience.editionType == ExperienceEditionType.original) {
        experience.editionType = ExperienceEditionType.originalModified;
      }
    }
    return DateTime.now();
  }
}

enum ExperienceDatePickerPurpose { startDate, endDate }
