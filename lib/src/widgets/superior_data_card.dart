import 'package:app_seguridad/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
// import 'package:megataxi_app/src/utils/app_colors.dart';

class SuperiorDataCard extends StatelessWidget {
  final String text;
  const SuperiorDataCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
              elevation: 10,
              margin: EdgeInsets.zero,
              child: Container(
                width: double.infinity,
                height: 80,
                color: AppColors.white,
                child:  Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        //logo imagen
                        const Image(image: AssetImage("assets/images/taxi.png"), width: 50, height: 50),
                        const SizedBox(width: 10),
                        Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              ),
            );
  }
}