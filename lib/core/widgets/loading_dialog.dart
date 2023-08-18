import 'dart:math';

import 'package:eldercare_guardian/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/font_size.dart';

import '../../app.dart';

class LoadingDialog {
  LoadingDialog._();
  static LoadingDialog instance = LoadingDialog._();
  OverlayEntry? _overlay;

  void show() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_overlay == null) {
        _overlay = OverlayEntry(
          builder: (context) => ColoredBox(
            color: Colors.black.withOpacity(.3),
            child: const Center(
              child: FPTLoading(
                color: [
                  AppColors.primaryColor,
                  AppColors.secondaryColor,
                  AppColors.accentColor,
                ],
              ),
            ),
          ),
        );
        Overlay.of(navigatorKey.currentState!.context).insert(_overlay!);
      }
    });
  }

  void hide() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _overlay?.remove();
      _overlay = null;
    });
  }
}

class LoadingContent extends StatelessWidget {
  const LoadingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: FPTLoading(
        color: [
          Colors.blue,
          Colors.orange,
          Colors.purple,
        ],
      ),
    );
  }
}

//#region ====================== old loading ======================== //
class GradientCircularProgressIndicator extends StatelessWidget {
  const GradientCircularProgressIndicator({
    required this.radius,
    required this.gradientColorsStart,
    required this.gradientColorsEnd,
    super.key,
    this.strokeWidth = 10.0,
    this.endPoint,
  });
  final double radius;
  final Color gradientColorsStart;
  final Color gradientColorsEnd;
  final double strokeWidth;
  final double? endPoint;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.fromRadius(radius),
      painter: GradientCircularProgressPainter(
        gradientColors: [
          gradientColorsEnd,
          gradientColorsStart,
        ],
        strokeWidth: strokeWidth,
        endPoint: endPoint,
      ),
    );
  }
}

class LoadingAnimated extends StatefulWidget {
  const LoadingAnimated({
    super.key,
    this.strokeWidth,
    this.radius,
    this.begin,
    this.end,
    this.gradientColorsStart,
    this.gradientColorsEnd,
    this.endPoint,
    this.size,
  });
  final Size? size;
  final double? strokeWidth;
  final double? radius;
  final double? begin;
  final double? end;
  final Color? gradientColorsStart;
  final Color? gradientColorsEnd;
  final double? endPoint;

  @override
  State<LoadingAnimated> createState() => _LoadingAnimatedState();
}

class _LoadingAnimatedState extends State<LoadingAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(
        begin: widget.begin ?? 0.0,
        end: widget.end ?? 1.0,
      ).animate(_controller),
      child: SizedBox(
        width: widget.size?.width,
        height: widget.size?.height,
        child: GradientCircularProgressIndicator(
          radius: widget.radius ?? 20.sf,
          strokeWidth: widget.strokeWidth ?? 5.sf,
          gradientColorsEnd: widget.gradientColorsEnd ?? Colors.white,
          gradientColorsStart: widget.gradientColorsStart ?? Colors.white,
          endPoint: widget.endPoint,
        ),
      ),
    );
  }
}

class GradientCircularProgressPainter extends CustomPainter {
  GradientCircularProgressPainter({
    required this.gradientColors,
    required this.strokeWidth,
    this.endPoint,
  });
  final List<Color> gradientColors;
  final double strokeWidth;
  final double? endPoint;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.height / 2;
    size = Size.fromRadius(radius);
    final offset = strokeWidth / 2;
    final scapToDegree = offset / radius;
    final startAngle = _degreeToRad(270) + scapToDegree;
    final sweepAngle = _degreeToRad(endPoint ?? 360) - (2 * scapToDegree);
    final rect =
        Rect.fromCircle(center: Offset(radius, radius), radius: radius);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    paint.shader = SweepGradient(
            colors: gradientColors,
            tileMode: TileMode.repeated,
            startAngle: _degreeToRad(270),
            endAngle: _degreeToRad(270 + 360.0))
        .createShader(
            Rect.fromCircle(center: Offset(radius, radius), radius: 0));

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  double _degreeToRad(double degree) => degree * pi / 180;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

//#endregion ================== end old loading ========================= //

//#region =================== new Loading ============================ //
class FPTLoading extends StatefulWidget {
  const FPTLoading({
    required this.color,
    Key? key,
  }) : super(key: key);
  final List<Color> color;

  @override
  State<FPTLoading> createState() => _FPTLoadingState();
}

class _FPTLoadingState extends State<FPTLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _offsetController;

  @override
  void initState() {
    super.initState();

    _offsetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 570),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: SizedBox(
          width: 56.sf,
          height: 24.sf,
          child: AnimatedBuilder(
            animation: _offsetController,
            builder: (_, __) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                widget.color.length,
                (index) => DotContainer(
                  controller: _offsetController,
                  offsetInterval: Interval(
                      0.18 + ((.18 * index) - .01), 0.28 + (.18 * index) - .01),
                  reverseOffsetInterval: Interval(
                      0.47 + ((.18 * index) - .01), 0.57 + (.18 * index) - .01),
                  color: widget.color[index],
                  size: 20.sf,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _offsetController.dispose();
    super.dispose();
  }
}

class DotContainer extends StatelessWidget {
  const DotContainer({
    required this.offsetInterval,
    required this.size,
    required this.color,
    required this.reverseOffsetInterval,
    required this.controller,
    Key? key,
  }) : super(key: key);
  final Interval offsetInterval;
  final double size;
  final Color color;

  final Interval reverseOffsetInterval;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final double maxDy = -(size * .34);

    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Opacity(
              opacity: controller.value <= offsetInterval.end ? 1 : 0,
              child: Transform.translate(
                offset: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(0, maxDy),
                )
                    .animate(
                      CurvedAnimation(
                        parent: controller,
                        curve: offsetInterval,
                      ),
                    )
                    .value,
                child: Container(
                  width: size * .6,
                  height: size * .6,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(size),
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: controller.value >= offsetInterval.end ? 1 : 0,
              child: Transform.translate(
                offset: Tween<Offset>(
                  begin: Offset(0, maxDy),
                  end: Offset.zero,
                )
                    .animate(
                      CurvedAnimation(
                        parent: controller,
                        curve: reverseOffsetInterval,
                      ),
                    )
                    .value,
                child: Container(
                  width: size * .6,
                  height: size * .6,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(size),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
