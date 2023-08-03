import 'dart:io';

import 'package:eldercare_guardian/core/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/logger.dart';
import 'package:huylnt_flutter_component/reusable_core/theme/app_text_styles.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/button_widget.dart';
import 'package:huylnt_flutter_component/reusable_core/widgets/complete_scaffold_widget.dart';

enum TakePictureScreenPurpose {
  postTaskEvidence,
  postEducationArtifactEvidence,
}

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    required this.artifactId,
    required this.takePictureScreenPurpose,
    super.key,
  });
  final String artifactId;
  final TakePictureScreenPurpose takePictureScreenPurpose;
  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  XFile? xFile;
  @override
  void initState() {
    super.initState();
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
      appBarTextWidget: const Text(
        'Taking picture',
        style: TextStyle(color: Colors.white),
      ),
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
            backgroundColor: AppColors.accentColor,
            onPressed: () {
              cameraController.takePicture().then((XFile? file) {
                if (mounted && file != null) {
                  setState(() {
                    xFile = file;
                  });
                }
              });
            })
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: ButtonWidget(
                  title: 'Re-take',
                  titleColor: AppColors.accentColor,
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () {
                    setState(() {
                      xFile = null;
                    });
                  },
                ),
              ),
              Flexible(
                child: ButtonWidget(
                  title: 'Confirm',
                  backgroundColor: AppColors.accentColor,
                  onPressed: () {
                    Navigator.pop(context, xFile);
                  },
                ),
              ),
            ],
          );
  }
}
