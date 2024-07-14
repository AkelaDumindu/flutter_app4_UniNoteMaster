import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/utils/colors.dart';
import 'package:flutter_app4_uninotemaster/utils/constant.dart';
import 'package:flutter_app4_uninotemaster/utils/text_style.dart';

class OpenBottomSheetWidget extends StatefulWidget {
  final Function() onNewNote;
  final Function() onNewCategory;
  const OpenBottomSheetWidget({
    super.key,
    required this.onNewNote,
    required this.onNewCategory,
  });

  @override
  State<OpenBottomSheetWidget> createState() => _OpenBottomSheetWidgetState();
}

class _OpenBottomSheetWidgetState extends State<OpenBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: AppColors.kCardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.kDefaultPadding * 1.5),
        child: Column(
          children: [
            GestureDetector(
              onTap: widget.onNewNote,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create a New Note",
                    style: AppTextStyles.appDescription,
                  ),
                  Icon(
                    Icons.arrow_right_outlined,
                    size: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              color: AppColors.kWhiteColor.withOpacity(0.3),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: widget.onNewCategory,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create New Note Category",
                    style: AppTextStyles.appDescription,
                  ),
                  Icon(
                    Icons.arrow_right_outlined,
                    size: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
