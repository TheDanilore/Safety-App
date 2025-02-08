import 'package:app_seguridad/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
// import 'package:megataxi_app/src/utils/app_colors.dart';

class ContainerButtoms extends StatelessWidget {
  final String textButton1;
  final String textButton2;
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;
  const ContainerButtoms({super.key, required this.textButton1, required this.textButton2, required this.onPressed1, required this.onPressed2});

  @override
  Widget build(BuildContext context) {
    return Container(
         height: 50,
          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextButton(onPressed:onPressed1, child:   Text(textButton1)),
                              ),
                              Container(
                                height: 20,
                                width: 2,
                                decoration: const BoxDecoration(
                                  color: AppColors.black
                                ),
                                ),
                              Expanded(
                                child: TextButton(onPressed: onPressed2, child:   Text(textButton2)),
                              )
                            ],
                          ),
                        );
  }
}