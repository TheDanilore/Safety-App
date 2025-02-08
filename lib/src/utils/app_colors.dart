import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF02164A);
  static const brown = Color(0xFF3E3E3E);
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const green = Color.fromARGB(255, 47, 215, 5);
  static const grey = Color(0xFFE0E0E0);
  static const red = Color(0xFFE53935);
  static const blue = Color(0xFF1E88E5);
  static const colorfond = Color(0xFFD9D9D9);

  static LinearGradient gradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.bottomCenter,
    colors: [
      primary.withOpacity(0.8),
      brown.withOpacity(0.4),
    ],
  );
}
