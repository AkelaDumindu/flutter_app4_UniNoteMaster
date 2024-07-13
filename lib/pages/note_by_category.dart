import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/modals/note_modals.dart';
import 'package:flutter_app4_uninotemaster/services/note_service.dart';

class NoteByCategory extends StatefulWidget {
  final String category;
  const NoteByCategory({
    super.key,
    required this.category,
  });

  @override
  State<NoteByCategory> createState() => _NoteByCategoryState();
}

class _NoteByCategoryState extends State<NoteByCategory> {
  List<NoteModals> noteList = [];
  final noteService = NoteService();

  @override
  void initState() {
    super.initState();
    setState(() {
      _loadCategorynote();
    });
  }

  // load relevant category note
  Future<void> _loadCategorynote() async {
    noteList = await noteService.getNotesBYCategory(widget.category);
    setState(() {
      print(noteList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
    );
  }
}
