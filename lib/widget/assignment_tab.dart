import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/helpers/snackbar.dart';
import 'package:flutter_app4_uninotemaster/modals/assignment_modals.dart';
import 'package:flutter_app4_uninotemaster/services/assignment_service.dart';
import 'package:flutter_app4_uninotemaster/utils/router_pages.dart';
import 'package:flutter_app4_uninotemaster/widget/assignment_card.dart';

class AssignmentTab extends StatefulWidget {
  final List<AssignmentModals> incompletedAssignment;
  final List<AssignmentModals> completedAssignment;
  const AssignmentTab(
      {super.key,
      required this.incompletedAssignment,
      required this.completedAssignment});

  @override
  State<AssignmentTab> createState() => _AssignmentTabState();
}

class _AssignmentTabState extends State<AssignmentTab> {
  // mark as done
  void _markAsDone(AssignmentModals ass) async {
    try {
      //updated assignments
      final AssignmentModals updatedAss = AssignmentModals(
        title: ass.title,
        date: ass.date,
        time: ass.time,
        icCompleted: true,
      );
      await AssignmentService().markAsDone(updatedAss);
      //show snackbar
      AppHelpers.showSnackBar(context, "Marked as Done");
      setState(() {
        widget.incompletedAssignment.remove(ass);
        widget.completedAssignment.add(ass);
      });
      RouterClass.router.go("/assignment");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // sort the according to the date
    setState(() {
      widget.incompletedAssignment.sort((a, b) => a.date.compareTo(b.date));
    });
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.incompletedAssignment.length,
              itemBuilder: (context, index) {
                final AssignmentModals ass =
                    widget.incompletedAssignment[index];
                return AssignmentCard(
                  assignments: ass,
                  isCompleted: false,
                  onCheckBoxChanged: () {
                    _markAsDone(ass);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
