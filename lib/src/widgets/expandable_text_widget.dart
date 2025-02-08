// ignore_for_file: library_private_types_in_public_api

import 'package:app_seguridad/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
// import 'package:megataxi_app/src/screen.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final int maxLines;
  final String text1;
  final String text2;

  const ExpandableTextWidget({
    required this.text,
    this.maxLines = 3,
    this.text1 = "Ver menos",
    this.text2 = "Ver más",
    super.key,
  });

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final isDarkMode = context.isDarkMode;
    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(
          text: widget.text,
          style: const TextStyle(
            color: AppColors.black,
            fontFamily: "CM",
            fontSize: 13,
          ),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          maxLines: widget.maxLines,
        );
        textPainter.layout(maxWidth: constraints.maxWidth);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: const TextStyle(
                color: AppColors.black,
                fontFamily: "CR",
                fontSize: 13,
              ),
              textAlign: TextAlign.justify,
              maxLines: _isExpanded ? null : widget.maxLines,
              overflow: _isExpanded ? TextOverflow.clip : TextOverflow.ellipsis,
            ),
            if (textPainter
                .didExceedMaxLines) // Mostrar el botón solo si hay overflow
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: _toggleExpanded,
                  child: Text(
                    _isExpanded ? widget.text1 : widget.text2,
                    style: const TextStyle(
                      color: AppColors.red,
                      fontFamily: "CB",
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
