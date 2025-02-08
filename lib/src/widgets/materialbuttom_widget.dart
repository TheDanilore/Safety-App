import 'package:app_seguridad/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
// import 'package:megataxi_app/src/utils/app_colors.dart';

class MaterialbuttomWidget extends StatelessWidget {
  final String? assetImage;
  final String? text;
  final VoidCallback onPressed;
  final bool isImage;
  final Color color;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  const MaterialbuttomWidget({
    super.key,
    this.assetImage,
    this.text,
    required this.onPressed,
    this.isImage = true,
    this.color = AppColors.white,
    this.textColor = AppColors.primary,
    this.padding = const EdgeInsets.symmetric(horizontal: 25),
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: MaterialButton(
        height: 45,
        elevation: 10,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
          side: const BorderSide(
            color: AppColors.primary,
            width: 1,
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isImage
                ? Image(image: AssetImage(assetImage!), height: 30, width: 30)
                : const SizedBox(),
            isImage ? const SizedBox(width: 15) : const SizedBox(),
            Flexible(
              child: Text(
                text!,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontFamily: "ADB",
                ),
                textAlign: TextAlign.center,
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}
