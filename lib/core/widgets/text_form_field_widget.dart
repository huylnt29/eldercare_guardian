import 'package:flutter/material.dart';
import 'package:flutterui_modifiers/flutterui_modifiers.dart';

import '../theme/app_text_styles.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    required this.textInputType,
    required this.colorTheme,
    required this.labelText,
    this.controller,
    this.validator,
    super.key,
  });
  final TextInputType textInputType;
  final Color colorTheme;
  final String labelText;
  final TextEditingController? controller;
  // ignore: prefer_typing_uninitialized_variables
  final String? Function(String?)? validator;
  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        style: TextStyle(color: widget.colorTheme),
        cursorColor: widget.colorTheme,
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
          label: Text(widget.labelText),
          focusColor: widget.colorTheme,
          labelStyle: AppTextStyles.heading3(widget.colorTheme),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.colorTheme),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.colorTheme),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: widget.colorTheme),
          ),
        ),
      ).margin(top: 20, horizontal: 20),
    );
  }
}
