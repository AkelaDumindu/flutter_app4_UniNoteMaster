import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/modals/assignment_modals.dart';
import 'package:flutter_app4_uninotemaster/widget/assignment_card.dart';

class AssignmentTab extends StatefulWidget {
  final List<AssignmentModals> incompletedAssignment;
  const AssignmentTab({super.key, required this.incompletedAssignment});

  @override
  State<AssignmentTab> createState() => _AssignmentTabState();
}

class _AssignmentTabState extends State<AssignmentTab> {
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
              itemCount: widget.incompletedAssignment.length,
              itemBuilder: (context, index) {
                final AssignmentModals ass =
                    widget.incompletedAssignment[index];
                return AssignmentCard(assignments: ass, isCompleted: false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
