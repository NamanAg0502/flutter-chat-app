import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/index.dart';

final appTheme = ThemeData(
    primaryColor: AppColors.appBg,
    scaffoldBackgroundColor: AppColors.appBg,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.appBg),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.appBg2),
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: TextTheme(
      labelLarge: GoogleFonts.poppins(
        fontSize: Sizes.dimen_30,
        fontWeight: FontWeight.w600,
        color: AppColors.appText,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: Sizes.dimen_18,
        fontWeight: FontWeight.w400,
        color: AppColors.appText,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: Sizes.dimen_14,
        fontWeight: FontWeight.w400,
        color: AppColors.appText,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: Sizes.dimen_18,
        fontWeight: FontWeight.w400,
        color: AppColors.appText,
      ),
    ));
