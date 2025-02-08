// ignore_for_file: library_private_types_in_public_api

import 'package:app_seguridad/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
// import 'package:megataxi_app/src/screen.dart';

class CustomDropdownButtonFormField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final List<String> items;
  final Function(String?) onChanged;
  final String? value;
  final String? Function(String?)? validator;
  final Color color;
  final double borderRadius;
  final bool showIcon;

  const CustomDropdownButtonFormField({
    super.key,
    this.labelText,
    this.hintText,
    required this.items,
    required this.onChanged,
    required this.value,
    this.validator,
    this.color = AppColors.brown,
    this.borderRadius = 10,
    this.showIcon = true,
  });

  @override
  _CustomDropdownButtonFormFieldState createState() =>
      _CustomDropdownButtonFormFieldState();
}

class _CustomDropdownButtonFormFieldState
    extends State<CustomDropdownButtonFormField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      style: TextStyle(
        fontFamily: "CB",
        color: widget.color,
        fontSize: 17,
      ),
      value: widget.value,
      decoration:
          inputDecorationDropdownButton(widget.labelText, widget.hintText),
      icon: widget.showIcon
          ? const Icon(
              Icons.arrow_drop_down_rounded,
              color: AppColors.green,
            )
          : const SizedBox.shrink(),
      iconSize: 25,
      items: widget.items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(
              fontFamily: "CB",
              color: widget.color,
              fontSize: 17,
            ),
          ),
        );
      }).toList(),
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }

  InputDecoration inputDecorationDropdownButton(
      String? labelText, String? hintText) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: TextStyle(color: widget.color, fontFamily: "CB"),
      labelStyle: TextStyle(color: widget.color, fontFamily: "CB"),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: BorderSide(
          color: widget.color,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: BorderSide(
          color: widget.color,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: BorderSide(
          color: widget.color,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: BorderSide(
          color: widget.color,
          width: 2,
        ),
      ),
    );
  }
}
