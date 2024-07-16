import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/helpers/snackbar.dart';
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
  final TextEditingController _assignmentController = TextEditingController();
  late TabController _tabController;
  @override
  void dispose() {
    _tabController.dispose();
    _assignmentController.dispose();
    super.dispose();
  }

  //create tab bar

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

  //method to add assignment

  void _addAss() async {
    try {
      if (_assignmentController.text.isNotEmpty) {
        final AssignmentModals newAss = AssignmentModals(
          title: _assignmentController.text,
          date: DateTime.now(),
          time: DateTime.now(),
          icCompleted: false,
        );
        await AssignmentService().addAssignment(newAss);
        setState(() {
          allAssignments.add(newAss);
          incompletedAssignments.add(newAss);
        });

        AppHelpers.showSnackBar(context, "Task Added");
        Navigator.pop(context);
      }
    } catch (e) {
      AppHelpers.showSnackBar(context, "Failed to add task");
      print(e);
    }
  }

  //open add model page
  void openMessageModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.kCardColor,
          title: Text(
            "Add Task",
            style: AppTextStyles.appDescription.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.kWhiteColor),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(
                  controller: _assignmentController,
                  style: TextStyle(
                    color: AppColors.kWhiteColor,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter your task",
                    hintStyle: AppTextStyles.appDescriptionSmall,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _addAss();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  AppColors.kFabColor,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              child: Text(
                "Add Task",
                style: AppTextStyles.appButton,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.kWhiteColor,
                ),
              ),
            )
          ],
        );
      },
    );
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
        onPressed: () {
          openMessageModal(context);
        },
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
            completedAssignment: completedAssignments,
          ),
          CompletedTab(
            completedAssignments: completedAssignments,
            inCompletedAssignments: incompletedAssignments,
          ),
        ],
      ),
    );
  }
}
