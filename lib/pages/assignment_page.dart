import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/utils/colors.dart';
import 'package:flutter_app4_uninotemaster/utils/text_style.dart';
import 'package:flutter_app4_uninotemaster/widget/assignment_tab.dart';
import 'package:flutter_app4_uninotemaster/widget/completed_tab.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({super.key});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage>
    with SingleTickerProviderStateMixin {
  //create tab bar
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text(
                "Assignment",
                style: AppTextStyles.appDescription,
              ),
            ),
            Tab(
              child: Text(
                "Completed",
                style: AppTextStyles.appDescription,
              ),
            ),
          ],
        ),
      ),

      //floating aaction button

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          side: BorderSide(
            color: AppColors.kWhiteColor,
            width: 2,
          ),
        ),
        child: Icon(
          Icons.add,
          color: AppColors.kWhiteColor,
          size: 30,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AssignmentTab(),
          CompletedTab(),
        ],
      ),
    );
  }
}
