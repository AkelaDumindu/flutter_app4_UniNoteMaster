import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/modals/assignment_modals.dart';

class CompletedTab extends StatefulWidget {
  final List<AssignmentModals> completedAssignments;
  const CompletedTab({
    super.key,
    required this.completedAssignments,
  });

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Completed"),
    );
  }
}
