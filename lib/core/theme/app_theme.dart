import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    primaryColor: AppColors.primaryColor,
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      titleLarge: AppTextStyles.title,
      bodyMedium: AppTextStyles.body,
      bodySmall: AppTextStyles.caption,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      foregroundColor: AppColors.blackColor,
      centerTitle: false,
      titleTextStyle: AppTextStyles.title,
      elevation: 0.0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppTextStyles.body.copyWith(color: AppColors.greyColor),
      fillColor: AppColors.whiteColor,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.greyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
