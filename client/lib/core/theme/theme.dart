import 'package:client/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final dartTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Pallete.borderColor, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Pallete.gradient2, width: 3),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
