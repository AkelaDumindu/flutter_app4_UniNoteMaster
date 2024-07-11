import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/utils/colors.dart';

class ThemeClass {
  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().primaryColor,
    scaffoldBackgroundColor: AppColors.kBgColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kBgColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.kFabColor,
    ),
  );
}
