// lib/config/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:inmuno/utils/colors.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.primaryGreen,
      scaffoldBackgroundColor: AppColors.backgroundWhite,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGreen,
        primary: AppColors.primaryGreen,
        secondary: AppColors.greenAccent,
        // ignore: deprecated_member_use
        background: AppColors.greenBackground,
        error: AppColors.errorRed,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primaryGreen,
        selectionColor: AppColors.greenLight,
        selectionHandleColor: AppColors.primaryGreen,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.darkText),
        bodyMedium: TextStyle(color: AppColors.mediumText),
        bodySmall: TextStyle(color: AppColors.lightText),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: AppColors.backgroundWhite,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: AppColors.backgroundWhite,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryGreen,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderGray),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryGreen, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        labelStyle: const TextStyle(color: AppColors.mediumText),
      ),
      highlightColor: Colors.transparent,
      splashColor: AppColors.primaryGreen.withOpacity(0.2),
    );
  }

  static ThemeData datePickerTheme(BuildContext context, Widget child) {
    return Theme.of(context).copyWith(
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryGreen,
        onPrimary: Colors.white,
        onSurface: Colors.black87,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryGreen,
        ),
      ),
    );
  }

  static Widget datePickerBuilder(BuildContext context, Widget? child) {
    return Theme(
      data: datePickerTheme(context, child!),
      child: Dialog(
        child: child,
      ),
    );
  }
}
