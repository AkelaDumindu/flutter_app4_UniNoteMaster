import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/helpers/snackbar.dart';
import 'package:flutter_app4_uninotemaster/modals/assignment_modals.dart';
import 'package:flutter_app4_uninotemaster/services/assignment_service.dart';
import 'package:flutter_app4_uninotemaster/utils/router_pages.dart';
import 'package:flutter_app4_uninotemaster/widget/assignment_card.dart';

class CompletedTab extends StatefulWidget {
  final List<AssignmentModals> completedAssignments;
  final List<AssignmentModals> inCompletedAssignments;
  const CompletedTab({
    super.key,
    required this.completedAssignments,
    required this.inCompletedAssignments,
  });

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  // mark as done
  void _removeMark(AssignmentModals ass) async {
    try {
      //updated assignments
      final AssignmentModals updatedAss = AssignmentModals(
        title: ass.title,
        date: ass.date,
        time: ass.time,
        icCompleted: false,
      );
      await AssignmentService().markAsDone(updatedAss);
      //show snackbar
      AppHelpers.showSnackBar(context, "remove from completed");
      setState(() {
        widget.completedAssignments.remove(ass);
        widget.inCompletedAssignments.add(ass);
      });
      RouterClass.router.go("/assignment");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              itemCount: widget.completedAssignments.length,
              itemBuilder: (context, index) {
                final AssignmentModals ass = widget.completedAssignments[index];
                return Dismissible(
                  key: Key(ass.id.toString()),
                  onDismissed: (direction) {
                    setState(() {
                      widget.completedAssignments.removeAt(index);
                      AssignmentService().deleteAssignment(ass);
                    });

                    AppHelpers.showSnackBar(context, "Deleted");
                  },
                  child: AssignmentCard(
                    assignments: ass,
                    isCompleted: false,
                    onCheckBoxChanged: () {
                      _removeMark(ass);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
