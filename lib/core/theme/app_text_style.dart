import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final TextStyle heading = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
    letterSpacing: 0.2,
  );
  static final TextStyle title = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
    letterSpacing: 0.2,
  );
  static final TextStyle body = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.blackColor,
    letterSpacing: 0.2,
    height: 1.5,
  );
  static final TextStyle caption = GoogleFonts.poppins(
    fontSize: 12,
    color: AppColors.greyColor,
    letterSpacing: 0.4,
  );
}
