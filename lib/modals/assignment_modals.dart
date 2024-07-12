import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'assignment_modals.g.dart';

@HiveType(typeId: 2)
class AssignmentModals {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final DateTime time;

  @HiveField(4)
  final bool icCompleted;

  AssignmentModals({
    String? id,
    required this.title,
    required this.date,
    required this.time,
    required this.icCompleted,
  }) : id = id ?? const Uuid().v4();
}
