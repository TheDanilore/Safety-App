
import 'package:flutter/material.dart';

class CardWidgetSuperior extends StatelessWidget {
  final String text;
  final bool isWidget;
  final Widget? widget;
  const CardWidgetSuperior({
    super.key, 
    required this.text,
    this.isWidget = false,
    this.widget
  });

  @override
  Widget build(BuildContext context) {
    return Card(
       elevation: 2,
       margin: const EdgeInsets.all(0),
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(0)
       ),
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             IconButton(
               icon: const Icon(Icons.arrow_back),
               onPressed: () {
                 Navigator.pop(context);
               },
             ),
           const SizedBox(width: 10),
            Text(text, style: const TextStyle(fontSize: 18.0)),
            const Spacer(),
            if(isWidget) widget!,
           ],
         ),
       ),
     );
  }
}