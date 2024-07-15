import 'package:flutter/material.dart';

class AssignmentTab extends StatefulWidget {
  const AssignmentTab({super.key});

  @override
  State<AssignmentTab> createState() => _AssignmentTabState();
}

class _AssignmentTabState extends State<AssignmentTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Assignment"),
    );
  }
}
