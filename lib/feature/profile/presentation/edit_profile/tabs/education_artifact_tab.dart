part of '../edit_profile_screen.dart';

class EducationArtifactTab extends StatefulWidget {
  const EducationArtifactTab({super.key});

  @override
  State<EducationArtifactTab> createState() => _EducationArtifactTabState();
}

class _EducationArtifactTabState extends State<EducationArtifactTab> {
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
                itemBuilder: (context, index) => buildEducationArtifactListItem(
                  profileBloc.state.tempProfile!.educationArtifacts[index]!,
                ),
                separatorBuilder: (context, index) => 24.vSpace,
                itemCount:
                    profileBloc.state.tempProfile!.educationArtifacts.length,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: keyboardInvisible,
              builder: (context, value, _) {
                if (value) {
                  return ButtonWidget(
                    title: 'Add more',
                    onPressed: () =>
                        profileBloc.add(AddMoreEducationArtifact()),
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

  Widget buildEducationArtifactListItem(EducationArtifact educationArtifact) {
    final titleController = TextEditingController(
        text: educationArtifact.title ?? ErrorMessage.isNotDetermined);
    final descriptionController = TextEditingController(
        text: educationArtifact.description ?? ErrorMessage.isNotDetermined);
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
                DeleteEducationArtifact(educationArtifact),
              );
              Navigator.of(context).pop();
            },
            message: 'Do you want to delete this certificate?',
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 4.sf,
          vertical: 18.sf,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(18.sf),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  TextFormFieldWidget(
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
                      educationArtifact.title = titleController.text;
                      if (educationArtifact.editionType ==
                          EducationArtifactEditionType.original) {
                        educationArtifact.editionType =
                            EducationArtifactEditionType.originalModified;
                      }
                    },
                    controller: titleController,
                    textInputType: TextInputType.text,
                    colorTheme: AppColors.textColor,
                    labelText: 'Title',
                  ),
                  TextFormFieldWidget(
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
                      educationArtifact.description =
                          descriptionController.text;
                      if (educationArtifact.editionType ==
                          EducationArtifactEditionType.original) {
                        educationArtifact.editionType =
                            EducationArtifactEditionType.originalModified;
                      }
                    },
                    controller: descriptionController,
                    textInputType: TextInputType.text,
                    colorTheme: AppColors.textColor,
                    labelText: 'Description',
                  ),
                ],
              ),
            ),
            12.hSpace,
            InkWell(
              onTap: () => onNavigatingTakePictureScreen(educationArtifact.id!),
              child: (educationArtifact.editionType ==
                      EducationArtifactEditionType.original)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100.sf),
                      child: CachedNetWorkImageWidget(
                        width: 112.sf,
                        height: 112.sf,
                        imageUrl: educationArtifact.imageEvidence ??
                            FakedData.emptyImagePath,
                      ),
                    )
                  : (educationArtifact.imageEvidence != null
                      ? Image.file(
                          File(educationArtifact.imageEvidence!),
                          width: 90.sf,
                        )
                      : Image.asset(
                          Assets.images.emptyImage.path,
                          width: 90.sf,
                        )),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onNavigatingTakePictureScreen(String educationArtifactId) async {
    final xFile = await Routes.router.navigateTo(
      context,
      RoutePath.takePictureScreen,
      routeSettings: RouteSettings(
        arguments: {
          'artifactId': educationArtifactId,
          'takePictureScreenPurpose':
              TakePictureScreenPurpose.postEducationArtifactEvidence,
        },
      ),
    );
    if (xFile != null) {
      profileBloc.add(TemporarilyPostEducationArtifactEvidence(
        educationArtifactId,
        xFile,
      ));
    }
  }
}
