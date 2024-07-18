import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/helpers/snackbar.dart';
import 'package:flutter_app4_uninotemaster/modals/assignment_modals.dart';
import 'package:flutter_app4_uninotemaster/pages/assignment_data_inherited.dart';
import 'package:flutter_app4_uninotemaster/services/assignment_service.dart';
import 'package:flutter_app4_uninotemaster/utils/router_pages.dart';
import 'package:flutter_app4_uninotemaster/widget/assignment_card.dart';

class AssignmentTab extends StatefulWidget {
  final List<AssignmentModals> incompletedAssignment;
  final List<AssignmentModals> completedAssignment;

  const AssignmentTab({
    super.key,
    required this.incompletedAssignment,
    required this.completedAssignment,
  });

  @override
  State<AssignmentTab> createState() => _AssignmentTabState();
}

class _AssignmentTabState extends State<AssignmentTab> {
  // Mark as done
  void _markAsDone(AssignmentModals ass) async {
    try {
      final AssignmentModals updatedAss = AssignmentModals(
        id: ass.id,
        title: ass.title,
        date: ass.date,
        time: ass.time,
        icCompleted: true,
      );

      await AssignmentService().markAsDone(updatedAss);

      setState(() {
        widget.incompletedAssignment.remove(ass);
        widget.completedAssignment.add(updatedAss);
      });

      AppHelpers.showSnackBar(context, "Marked as Done");

      // Navigate back to home page
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      AppHelpers.showSnackBar(context, "Failed to mark as done");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sort assignments according to the date
    widget.incompletedAssignment.sort((a, b) => a.date.compareTo(b.date));

    return AssignmentData(
      assignmentData: widget.incompletedAssignment,
      onAssignmentChange: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.incompletedAssignment.length,
                itemBuilder: (context, index) {
                  final AssignmentModals ass =
                      widget.incompletedAssignment[index];
                  return Dismissible(
                    key: Key(ass.id.toString()),
                    onDismissed: (direction) {
                      setState(() {
                        widget.incompletedAssignment.removeAt(index);
                        AssignmentService().deleteAssignment(ass);
                      });
                      AppHelpers.showSnackBar(context, "Deleted");
                    },
                    child: AssignmentCard(
                      assignments: ass,
                      isCompleted: false,
                      onCheckBoxChanged: () {
                        _markAsDone(ass);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
