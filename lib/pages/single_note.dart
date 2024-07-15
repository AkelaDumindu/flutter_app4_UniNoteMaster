import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/modals/note_modals.dart';
import 'package:flutter_app4_uninotemaster/utils/colors.dart';
import 'package:flutter_app4_uninotemaster/utils/constant.dart';
import 'package:flutter_app4_uninotemaster/utils/text_style.dart';
import 'package:intl/intl.dart';

class SingleNotePage extends StatelessWidget {
  final NoteModals note;
  const SingleNotePage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    // Format the date
    final formattedDate = DateFormat.yMMMd().format(note.date);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              note.title,
              style: AppTextStyles.appTitle,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              note.category,
              style: AppTextStyles.appButton.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.3),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              formattedDate,
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kFabColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              note.content,
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
