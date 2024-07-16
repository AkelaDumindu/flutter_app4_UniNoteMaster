import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/modals/assignment_modals.dart';
import 'package:flutter_app4_uninotemaster/utils/colors.dart';
import 'package:flutter_app4_uninotemaster/utils/text_style.dart';

class AssignmentCard extends StatefulWidget {
  final AssignmentModals assignments;
  final bool isCompleted;
  const AssignmentCard({
    super.key,
    required this.assignments,
    required this.isCompleted,
  });

  @override
  State<AssignmentCard> createState() => _AssignmentCardState();
}

class _AssignmentCardState extends State<AssignmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          widget.assignments.title,
          style: AppTextStyles.appDescription,
        ),
        subtitle: Row(
          children: [
            Text(
              '${widget.assignments.date.day}/${widget.assignments.date.month}/${widget.assignments.date.year}',
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '${widget.assignments.time.hour}:${widget.assignments.time.minute}',
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          value: widget.isCompleted,
          onChanged: (value) {},
        ),
      ),
    );
  }
}
