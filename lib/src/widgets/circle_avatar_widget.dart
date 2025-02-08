import 'package:app_seguridad/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
// import 'package:megataxi_app/src/utils/app_colors.dart';

class CircleAvatarWidget extends StatelessWidget {
  final String? assetImage;
  final VoidCallback onPressed;
  final Color color;

  final EdgeInsetsGeometry padding;
  const CircleAvatarWidget({
    super.key,
    this.assetImage,
    required this.onPressed,
    this.color = AppColors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 25),
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.primary,
      customBorder: const CircleBorder(),
      onTap: onPressed,
      child: Padding(
        padding: padding,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary,
              width: 1,
            ),
          ),
          child: CircleAvatar(
            backgroundColor: color,
            radius: 25,
            child: Image(
              image: AssetImage(assetImage!),
              height: 35,
              width: 35,
            ),
          ),
        ),
      ),
    );
  }
}
