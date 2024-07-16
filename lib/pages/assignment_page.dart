import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/modals/assignment_modals.dart';
import 'package:flutter_app4_uninotemaster/services/assignment_service.dart';
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
  late List<AssignmentModals> allAssignments = [];
  late List<AssignmentModals> completedAssignments = [];
  late List<AssignmentModals> incompletedAssignments = [];
  final AssignmentService assignmentService = AssignmentService();

  //create tab bar
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _checkIfUserIsNewAndCreateInitialNotes();
  }

  void _checkIfUserIsNewAndCreateInitialNotes() async {
    // Check if the notes box is empty
    final bool isNewUser = await assignmentService.isNewUser();

    if (isNewUser) {
      // If the user is new, create the initial notes
      await assignmentService.createInitialAssignment();
    }

    // load the notes
    _loadAssignment();
  }

  Future<void> _loadAssignment() async {
    final List<AssignmentModals> loadedAss =
        await assignmentService.loadAssignment();

    setState(() {
      allAssignments = loadedAss;
      incompletedAssignments =
          allAssignments.where((ass) => !ass.icCompleted).toList();
      completedAssignments =
          allAssignments.where((ass) => ass.icCompleted).toList();
    });
    print(allAssignments.length);
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
        children: [
          AssignmentTab(
            incompletedAssignment: incompletedAssignments,
          ),
          CompletedTab(
            completedAssignments: completedAssignments,
          ),
        ],
      ),
    );
  }
}
