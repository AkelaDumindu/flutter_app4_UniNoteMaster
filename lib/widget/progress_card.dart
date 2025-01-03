import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/utils/colors.dart';
import 'package:flutter_app4_uninotemaster/utils/constant.dart';
import 'package:flutter_app4_uninotemaster/utils/text_style.dart';

class ProgressCard extends StatefulWidget {
  final int completedTask;
  final int totalTask;
  const ProgressCard({
    super.key,
    required this.completedTask,
    required this.totalTask,
  });

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    // calculate progress presentage
    double progresPresentage = widget.totalTask != 0
        ? (widget.completedTask / widget.totalTask) * 100
        : 0;
    return Container(
      padding: const EdgeInsets.all(AppConstants.kDefaultPadding),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Today's Progress",
                style: AppTextStyles.appSubtitle,
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(
                  "You have completed ${widget.completedTask} out of ${widget.totalTask} tasks, \nkeep up the progress!",
                  style: AppTextStyles.appDescriptionSmall.copyWith(
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                  ),
                ),
              )
            ],
          ),
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.18,
                height: MediaQuery.of(context).size.width * 0.18,
                decoration: BoxDecoration(
                  gradient: AppColors().kPrimaryGradient,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    "$progresPresentage%",
                    style: AppTextStyles.appSubtitle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
