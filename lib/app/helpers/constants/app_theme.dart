import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    primaryColor: AppColors.white,
    canvasColor: AppColors.white,
    cardTheme: const CardTheme(
      color: AppColors.white,
    ),
    primaryColorDark: AppColors.white,
    iconTheme: const IconThemeData(
      color: AppColors.black,
    ),
    fontFamily: "Inter",
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedItemColor: Colors.white70,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.black,
      ),
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    cardColor: AppColors.white,
    unselectedWidgetColor: Colors.black45,
    focusColor: AppColors.white,
    dividerColor: AppColors.white,
    dropdownMenuTheme: const DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(
          Colors.white,
        ),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.inter(
        color: AppColors.black,
        fontSize: 30.sp,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.inter(
        color: AppColors.black,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: GoogleFonts.inter(
        color: AppColors.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: GoogleFonts.inter(
        color: AppColors.black,
        fontSize: 30.sp,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: GoogleFonts.inter(
        color: AppColors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: GoogleFonts.inter(
        color: AppColors.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: GoogleFonts.inter(
        color: AppColors.black,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: GoogleFonts.inter(
        color: AppColors.grey,
        fontSize: 11.sp,
        fontWeight: FontWeight.w300,
      ),
      titleSmall: GoogleFonts.inter(
        color: AppColors.grey,
        fontSize: 11.sp,
        fontWeight: FontWeight.normal,
      ),
    ),
  );

  static final ThemeData dark = ThemeData(
    primaryColor: Colors.black12,
    canvasColor: AppColors.black,
    cardTheme: const CardTheme(
      color: AppColors.black,
    ),
    primaryColorDark: AppColors.black,
    iconTheme: const IconThemeData(
      color: AppColors.white,
    ),
    fontFamily: "Inter",
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedItemColor: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.black,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.black,
      ),
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.black,
    useMaterial3: false,
    focusColor: AppColors.white,
    dividerColor: AppColors.black,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.inter(
        color: AppColors.white,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.inter(
        color: AppColors.white,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: GoogleFonts.inter(
        color: AppColors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: GoogleFonts.inter(
        color: AppColors.white,
        fontSize: 30.sp,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: GoogleFonts.inter(
        color: AppColors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: GoogleFonts.inter(
        color: AppColors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: GoogleFonts.inter(
        color: AppColors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w800,
      ),
      titleMedium: GoogleFonts.inter(
        color: AppColors.grey,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: GoogleFonts.inter(
        color: AppColors.white,
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
