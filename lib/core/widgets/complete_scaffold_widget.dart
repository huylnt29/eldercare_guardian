import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CompleteScaffoldWidget extends StatefulWidget {
  const CompleteScaffoldWidget({
    this.appBarOverlapped = false,
    this.backButtonEnabled = true,
    this.actions,
    required this.appBarTitle,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    Key? key,
    this.onTapScreen,
  }) : super(key: key);
  final bool? appBarOverlapped;
  final bool? backButtonEnabled;
  final List<Widget>? actions;
  final String appBarTitle;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final VoidCallback? onTapScreen;

  @override
  State<CompleteScaffoldWidget> createState() => _CompleteScaffoldWidgetState();
}

class _CompleteScaffoldWidgetState extends State<CompleteScaffoldWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        widget.onTapScreen?.call();
      },
      child: Scaffold(
        backgroundColor: widget.backgroundColor ?? AppColors.primaryColor,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        extendBodyBehindAppBar: widget.appBarOverlapped!,
        appBar: AppBar(
          leading: (widget.backButtonEnabled!)
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : Container(),
          actions: widget.actions,
          title: Text(widget.appBarTitle),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.black,
        ),
        body: widget.body,
        floatingActionButton: widget.floatingActionButton,
        bottomNavigationBar: widget.bottomNavigationBar,
      ),
    );
  }
}
