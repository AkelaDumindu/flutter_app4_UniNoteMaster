import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/utils/colors.dart';
import 'package:flutter_app4_uninotemaster/utils/text_style.dart';
import 'package:intl/intl.dart';

class HomeScreenAssignmentsCard extends StatelessWidget {
  final String assTitle;
  final String date;
  final String time;
  final bool isDone;
  const HomeScreenAssignmentsCard({
    super.key,
    required this.assTitle,
    required this.date,
    required this.time,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  assTitle,
                  style: AppTextStyles.appDescription.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${DateFormat.yMMMd().format(DateTime.parse(date))} ${DateFormat.Hm().format(
                    DateTime.parse(time),
                  )}',
                  style: AppTextStyles.appDescriptionSmall.copyWith(
                    color: AppColors.kWhiteColor.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isDone ? Icons.done_all_outlined : Icons.done_outlined,
            color: isDone ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }
}
