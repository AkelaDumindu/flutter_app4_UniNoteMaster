import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/modals/note_modals.dart';
import 'package:flutter_app4_uninotemaster/services/note_service.dart';
import 'package:flutter_app4_uninotemaster/utils/colors.dart';
import 'package:flutter_app4_uninotemaster/utils/constant.dart';
import 'package:flutter_app4_uninotemaster/utils/router_pages.dart';
import 'package:flutter_app4_uninotemaster/utils/text_style.dart';
import 'package:flutter_app4_uninotemaster/widget/notes_card.dart';
import 'package:flutter_app4_uninotemaster/widget/open_bottom_sheet.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  List<NoteModals> allNotes = [];
  final NoteService noteService = NoteService();
  Map<String, List<NoteModals>> notesWithCategory = {};

  @override
  void initState() {
    super.initState();
    _checkIfUserIsNewAndCreateInitialNotes();
  }

  void _checkIfUserIsNewAndCreateInitialNotes() async {
    // Check if the notes box is empty
    final bool isNewUser = await noteService.isNewUser();

    if (isNewUser) {
      // If the user is new, create the initial notes
      await noteService.createInitialNotes();
    }

    // load the notes
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final List<NoteModals> loadedNotes = await noteService.loadNote();
    final Map<String, List<NoteModals>> notesCategories =
        noteService.GetNotesByCategoryMap(loadedNotes);
    setState(() {
      allNotes = loadedNotes;
      notesWithCategory = notesCategories;
    });
    print(notesWithCategory);
  }

  //open bottom sheet
  void openBottomSheet() {
    showModalBottomSheet(
      //after opening modal back ground of note page
      barrierColor: AppColors.kWhiteColor.withOpacity(0.7),
      context: context,
      builder: (context) {
        return OpenBottomSheetWidget(
          onNewNote: () {
            //after click close modal
            Navigator.pop(context);

            // if extra value is false already have a category so go to create new note, as well as go to same page change according to the bool value, parameter assign according to the cretae new note page
            RouterClass.router.push("/create-note", extra: false);
          },
          onNewCategory: () {
            //after click close modal
            Navigator.pop(context);

            // if extra value is true, should create category for that so go to create new category, as well as go to same page change according to the bool value, parameter assign according to the cretae new note page
            RouterClass.router.push("/create-note", extra: true);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            RouterClass.router.go("/");
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openBottomSheet();
        },
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          side: BorderSide(
            color: AppColors.kWhiteColor,
            width: 2,
          ),
        ),
        child: Icon(
          Icons.add,
          color: AppColors.kWhiteColor,
          size: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Notes",
              style: AppTextStyles.appTitle,
            ),
            const SizedBox(
              height: 20,
            ),
            allNotes.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: Text(
                        "No notes available , click on the + button to add a new note",
                        style: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.7),
                          fontSize: AppConstants.kDefaultPadding,
                        ),
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppConstants.kDefaultPadding,
                      mainAxisSpacing: AppConstants.kDefaultPadding,
                      childAspectRatio: 6 / 4,
                    ),
                    itemCount: notesWithCategory.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          RouterClass.router.push(
                            "/category",
                            extra: notesWithCategory.keys.elementAt(index),
                          );
                        },
                        child: NotesCard(
                          noteCategory: notesWithCategory.keys.elementAt(index),
                          noteCount:
                              notesWithCategory.values.elementAt(index).length,
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
