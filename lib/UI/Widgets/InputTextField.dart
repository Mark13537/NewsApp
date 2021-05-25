import 'package:flutter/material.dart';
import 'package:news_app/Helpers/AppConstants.dart';

class InputTextField extends StatelessWidget {
  final bool isEnabled;
  final bool autoFocus;
  final String name;
  final TextEditingController controller;
  final Function(String) onValidate;
  final int maxLines;
  final TextStyle hintStyle;
  final InputBorder inputBorder;
  final TextStyle labelStyle;
  final TextStyle textStyle;
  final Function(String) onChanged;
  final EdgeInsetsGeometry contentPadding;
  final Widget suffix;
  final String errorText;

  const InputTextField({
    this.isEnabled = true,
    this.autoFocus = true,
    this.name,
    this.controller,
    this.onValidate,
    this.maxLines = 1,
    this.hintStyle,
    this.inputBorder,
    this.labelStyle,
    this.textStyle,
    this.onChanged,
    this.contentPadding,
    this.suffix,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.grey,
        primaryColorDark: Colors.black,
      ),
      child: TextFormField(
        enabled: isEnabled,
        autofocus: autoFocus,
        controller: controller,
        validator: onValidate,
        onChanged: onChanged,
        style: textStyle ?? regularTxtStyle,
        decoration: InputDecoration(
          errorText: errorText,
          suffixIcon: suffix,
          contentPadding: contentPadding,
          hintText: name,
          hintStyle: hintStyle ?? regularTxtStyle,
          focusedBorder: inputBorder ??
              UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
          border: inputBorder ??
              UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
          labelStyle: labelStyle ?? regularTxtStyle,
        ),
        maxLines: maxLines,
        cursorColor: Colors.grey,
      ),
    );
  }
}
