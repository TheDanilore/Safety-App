import 'package:app_seguridad/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
// import 'package:megataxi_app/src/screen.dart';

class CircularProgressWidget extends StatelessWidget {
  final String text;
  const CircularProgressWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text,style: const TextStyle(color: AppColors.primary),),
        const SizedBox(width: 10),
        const CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ],
    );
  }
}