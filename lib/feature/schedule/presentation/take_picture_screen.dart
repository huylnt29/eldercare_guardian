import 'dart:io';

import 'package:eldercare_guardian/core/theme/app_colors.dart';
import 'package:eldercare_guardian/feature/schedule/presentation/bloc/schedule_bloc.dart';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huylnt_flutter_component/reusable_core/enums/load_state.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/box_size.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/logger.dart';
import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/button_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/complete_scaffold_widget.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({required this.taskId, super.key});
  final String taskId;
  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  late ScheduleBloc scheduleBloc;
  XFile? xFile;
  @override
  void initState() {
    super.initState();
    scheduleBloc = context.read<ScheduleBloc>()..add(ResetStateEvent());
    startCamera();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void startCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
    );
    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      Logger.e(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompleteScaffoldWidget(
      appBarTitle: 'Taking picture',
      appBarOverlapped: false,
      backgroundColor: AppColors.textColor,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (xFile == null) {
      try {
        return SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              4.vSpace,
              Expanded(child: CameraPreview(cameraController)),
              buildButtons(),
            ],
          ),
        );
      } catch (e) {
        return Center(
          child: Text(
            'Connecting camera...',
            style: AppTextStyles.heading3(
              AppColors.textColor,
            ),
          ),
        );
      }
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          4.vSpace,
          Expanded(child: Image.file(File(xFile!.path))),
          buildButtons(),
        ],
      );
    }
  }

  Widget buildButtons() {
    return (xFile == null)
        ? ButtonWidget(
            title: 'Take',
            onPressed: () {
              cameraController.takePicture().then((XFile? file) {
                if (mounted && file != null) {
                  setState(() {
                    xFile = file;
                  });
                }
              });
            })
        : BlocConsumer<ScheduleBloc, ScheduleState>(
            listener: (context, state) {
              if (state.loadState == LoadState.loaded) {
                Navigator.pop(context, state.postTaskEvidenceSuccessfully);
              }
            },
            builder: (context, state) {
              if (state.loadState == LoadState.initial) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      title: 'Re-take',
                      titleColor: AppColors.accentColor,
                      backgroundColor: AppColors.primaryColor,
                      onPressed: () {
                        setState(() {
                          xFile = null;
                        });
                      },
                    ),
                    ButtonWidget(
                      title: 'Confirm',
                      onPressed: () {
                        scheduleBloc.add(PostTaskEvidenceEvent(
                          widget.taskId,
                          xFile!,
                        ));
                      },
                    ),
                  ],
                );
              } else if (state.loadState == LoadState.loading) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      title: 'Re-take',
                      titleColor: AppColors.accentColor,
                      backgroundColor: AppColors.primaryColor,
                      onPressed: () {},
                      disabled: true,
                    ),
                    ButtonWidget(
                      title: 'Posting...',
                      onPressed: () {},
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('This screen should be closed'),
                );
              }
            },
          );
  }
}
