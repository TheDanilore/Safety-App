import 'package:app_seguridad/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
// import 'package:megataxi_app/src/utils/app_colors.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final String fontFamily;
  final Color color;
  final TextAlign? textAlign;
  const TextWidget({
    super.key,
    required this.text,
    required this.fontSize,
    this.fontFamily = "PB",
    this.color = AppColors.black,
    this.textAlign = TextAlign.center,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: color,
      ),
      textAlign: textAlign,
    );
  }
}
