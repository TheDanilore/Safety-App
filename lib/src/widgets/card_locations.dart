import 'package:app_seguridad/src/utils/app_colors.dart';
import 'package:app_seguridad/src/widgets/text_widget.dart';
import 'package:flutter/material.dart';
// import 'package:megataxi_app/src/screen.dart';

class CardLocations extends StatelessWidget {
  final String pregunta;
  final String direction;
  final VoidCallback onPressed;
  const CardLocations({
    super.key,
    required this.pregunta,
    required this.direction,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(Icons.circle, color: AppColors.green, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: pregunta,
                    fontSize: 15,
                    textAlign: TextAlign.start,
                  ),
                  TextWidget(
                      text: direction,
                      fontSize: 12,
                      textAlign: TextAlign.start,
                      color: AppColors.green),
                ],
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.arrow_forward_ios_outlined,
                  color: AppColors.green, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
