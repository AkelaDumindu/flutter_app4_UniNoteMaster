import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/modals/assignment_modals.dart';

class AssignmentData extends InheritedWidget {
  final List<AssignmentModals> assignmentData;
  final Function() onAssignmentChange;

  AssignmentData({
    super.key,
    required super.child,
    required this.assignmentData,
    required this.onAssignmentChange,
  });

  static AssignmentData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AssignmentData>();
  }

  @override
  bool updateShouldNotify(covariant AssignmentData oldWidget) {
    print('updateShouldNotify');
    return assignmentData != oldWidget.assignmentData;
  }
}
