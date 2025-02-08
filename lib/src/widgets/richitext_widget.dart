import 'package:app_seguridad/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
// import 'package:megataxi_app/src/screen.dart';

class RichitextWidget extends StatelessWidget {
  final String text1;
  final String text2;
  const RichitextWidget({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontFamily: "PB",
            ),
          ),
          TextSpan(
            text: text2,
            style: const TextStyle(
              color: AppColors.brown,
            ),
          ),
        ],
      ),
    );
  }
}
