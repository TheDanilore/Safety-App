import 'package:app_seguridad/src/widgets/text_widget.dart';
import 'package:flutter/material.dart';
// import 'package:megataxi_app/src/widgets/text_widget.dart';

class ContainerRowUser extends StatelessWidget {
  final String username;
  const ContainerRowUser({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          child: Image(image: AssetImage("assets/images/avatar.png")),
        ),
        const SizedBox(width: 15),
        TextWidget(
          textAlign: TextAlign.start,
            text: "Bienvenido\n$username", fontSize: 20),
      ],
    );
  }
}
