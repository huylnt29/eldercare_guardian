import 'dart:io';

import 'package:eldercare_guardian/core/extensions/font_size_extensions.dart';
import 'package:eldercare_guardian/core/theme/app_colors.dart';
import 'package:eldercare_guardian/core/theme/app_text_styles.dart';
import 'package:eldercare_guardian/core/widgets/complete_scaffold_widget.dart';
import 'package:eldercare_guardian/feature/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/logger.dart';

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
    scheduleBloc = context.read<ScheduleBloc>();
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
      appBarOverlapped: true,
      body: buildBody(),
      floatingActionButton: (xFile == null)
          ? FloatingActionButton(
              onPressed: () {
                cameraController.takePicture().then((XFile? file) {
                  if (mounted && file != null) {
                    setState(() {
                      xFile = file;
                    });
                  }
                });
              },
              backgroundColor: AppColors.accentColor,
              child: const Icon(Icons.circle),
            )
          : FloatingActionButton(
              onPressed: () {},
              backgroundColor: AppColors.accentColor,
              child: const Icon(Icons.check),
            ),
    );
  }

  Widget buildBody() {
    if (xFile == null) {
      try {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            bottom: 18.sf,
          ),
          child: CameraPreview(cameraController),
        );
      } catch (e) {
        return Center(
            child: Text(
          'Connecting camera...',
          style: AppTextStyles.heading3(
            AppColors.textColor,
          ),
        ));
      }
    } else {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          bottom: 18.sf,
        ),
        child: Image.file(File(xFile!.path)),
      );
    }
  }
}
