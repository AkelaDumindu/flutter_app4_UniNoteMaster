import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/utils/colors.dart';
import 'package:flutter_app4_uninotemaster/utils/text_style.dart';

class AppHelpers {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.kFabColor,
        content: Text(
          message,
          style: AppTextStyles.appButton,
        ),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
