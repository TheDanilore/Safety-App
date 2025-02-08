import 'package:flutter/material.dart';

class ImputDecorationWidget extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool readOnly;
  final String? initialValue;
  const ImputDecorationWidget({
    super.key,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
    this.validator,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText!,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
      readOnly: readOnly,
      initialValue: initialValue,
      onTap: onTap,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
