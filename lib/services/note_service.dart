import 'package:flutter_app4_uninotemaster/modals/note_modals.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class NoteService {
  List<NoteModals> allNote = [
    NoteModals(
      id: const Uuid().v4(),
      title: "SE1012",
      category: "subjects",
      content:
          "Discussed project deadlines and deliverables. Assigned tasks to team members and set up follow-up meetings to track progress.",
      date: DateTime.now(),
    ),
    NoteModals(
      id: const Uuid().v4(),
      title: "Web Project",
      category: "Projects",
      content:
          "Discussed project deadlines and deliverables. Assigned tasks to team members and set up follow-up meetings to track progress.",
      date: DateTime.now(),
    ),
    NoteModals(
      id: const Uuid().v4(),
      title: "Methodologies",
      category: "Short Notes",
      content:
          "Discussed project deadlines and deliverables. Assigned tasks to team members and set up follow-up meetings to track progress.",
      date: DateTime.now(),
    ),
  ];

  //create the databse reference for note
  final _myBox = Hive.box('notes');

  // check the user is new?
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  // method to create initial notes if the box is empty
  Future<void> createInitialNotes() async {
    if (_myBox.isEmpty) {
      await _myBox.put("notes", allNote);
    }
  }

  // Method to load to notes
  Future<List<NoteModals>> loadNote() async {
    final dynamic notes = await _myBox.get('notes');
    if (notes != null && notes is List<dynamic>) {
      return notes.cast<NoteModals>().toList();
    }
    return [];
  }

  //loop through all notes and create an object where the key is the category and the value is the notes in that category

  Map<String, List<NoteModals>> GetNotesByCategoryMap(
      List<NoteModals> allNotes) {
    final Map<String, List<NoteModals>> noteByCategory = {};

    for (final note in allNotes) {
      if (noteByCategory.containsKey(note.category)) {
        noteByCategory[note.category]!.add(note);
      } else {
        noteByCategory[note.category] = [note];
      }
    }
    return noteByCategory;
  }

  // Method to get the notes according to the category

  Future<List<NoteModals>> getNotesBYCategory(String category) async {
    // get all notes from box
    final dynamic allNotes = await _myBox.get("notes");
    final List<NoteModals> notes = [];

    for (final note in allNotes) {
      if (note.category == category) {
        notes.add(note);
      }
    }
    return notes;
  }
}
