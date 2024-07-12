import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'note_modals.g.dart';

@HiveType(typeId: 1)
class NoteModals {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String content;

  @HiveField(4)
  final DateTime date;

  NoteModals({
    String? id,
    required this.title,
    required this.category,
    required this.content,
    required this.date,
  }) : id = id ?? const Uuid().v4();
}
