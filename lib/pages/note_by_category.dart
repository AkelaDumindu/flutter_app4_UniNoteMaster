import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/helpers/snackbar.dart';
import 'package:flutter_app4_uninotemaster/modals/note_modals.dart';
import 'package:flutter_app4_uninotemaster/services/note_service.dart';
import 'package:flutter_app4_uninotemaster/utils/constant.dart';
import 'package:flutter_app4_uninotemaster/utils/router_pages.dart';
import 'package:flutter_app4_uninotemaster/utils/text_style.dart';
import 'package:flutter_app4_uninotemaster/widget/note_category_card.dart';

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
    _loadCategorynote();
  }

  // Load relevant category note
  Future<void> _loadCategorynote() async {
    final notes = await noteService.getNotesBYCategory(widget.category);
    setState(() {
      noteList = notes;
    });
  }

  // edit note
  void _editNote(NoteModals note) {
    // navigate to edit page
    RouterClass.router.push("/edit-note", extra: note);
  }

  // delete note

  Future<void> _deleteNote(String id) async {
    try {
      await noteService.deleteNote(id);
      if (context.mounted) {
        AppHelpers.showSnackBar(context, "Note deleted successfully");
      }
    } catch (e) {
      AppHelpers.showSnackBar(context, "deleted note is failed");
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            RouterClass.router.push("/notes");
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.kDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                widget.category,
                style: AppTextStyles.appTitle,
              ),
              const SizedBox(height: 30),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppConstants.kDefaultPadding,
                  mainAxisSpacing: AppConstants.kDefaultPadding,
                  childAspectRatio: 7 / 11,
                ),
                itemCount: noteList.length,
                itemBuilder: (context, index) {
                  final note = noteList[index];
                  return NoteCategoryCard(
                    title: note.title,
                    categoryContent: note.content,
                    removeNote: () async {
                      // Add your remove note logic here
                      await _deleteNote(noteList[index].id);
                      setState(() {
                        noteList.removeAt(index);
                      });
                    },
                    editNote: () async {
                      // Add your edit note logic here
                      _editNote(noteList[index]);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
