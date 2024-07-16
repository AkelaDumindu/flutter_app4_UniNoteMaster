import 'package:flutter_app4_uninotemaster/modals/assignment_modals.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class AssignmentService {
  List<AssignmentModals> allAssignments = [
    AssignmentModals(
      id: const Uuid().v4(),
      title: "SE1012",
      date: DateTime.now(),
      time: DateTime.now(),
      icCompleted: false,
    ),
    AssignmentModals(
      id: const Uuid().v4(),
      title: "SE1012",
      date: DateTime.now(),
      time: DateTime.now(),
      icCompleted: false,
    ),
    AssignmentModals(
      id: const Uuid().v4(),
      title: "SE1012",
      date: DateTime.now(),
      time: DateTime.now(),
      icCompleted: false,
    ),
  ];

  //create the databse reference for note
  final _myBox = Hive.box('assignments');

  // check the user is new?
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  // method to create initial notes if the box is empty
  Future<void> createInitialAssignment() async {
    if (_myBox.isEmpty) {
      await _myBox.put("assignments", allAssignments);
    }
  }

  // Method to load to notes
  Future<List<AssignmentModals>> loadAssignment() async {
    final dynamic ass = await _myBox.get('assignments');
    if (ass != null && ass is List<dynamic>) {
      return ass.cast<AssignmentModals>().toList();
    }
    return [];
  }
}
