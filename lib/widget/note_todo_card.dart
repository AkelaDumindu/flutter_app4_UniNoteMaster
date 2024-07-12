import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/utils/colors.dart';
import 'package:flutter_app4_uninotemaster/utils/text_style.dart';

class NoteTodoCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  const NoteTodoCard(
      {super.key,
      required this.title,
      required this.description,
      required this.icon});

  @override
  State<NoteTodoCard> createState() => _NoteTodoCardState();
}

class _NoteTodoCardState extends State<NoteTodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: Column(
          children: [
            Icon(
              widget.icon,
              size: 40,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.title,
              style: AppTextStyles.appDescription,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.description,
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
