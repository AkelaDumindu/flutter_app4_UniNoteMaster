import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/helpers/snackbar.dart';
import 'package:flutter_app4_uninotemaster/modals/note_modals.dart';
import 'package:flutter_app4_uninotemaster/services/note_service.dart';
import 'package:flutter_app4_uninotemaster/utils/colors.dart';
import 'package:flutter_app4_uninotemaster/utils/constant.dart';
import 'package:flutter_app4_uninotemaster/utils/router_pages.dart';
import 'package:flutter_app4_uninotemaster/utils/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class CreateNewNotePage extends StatefulWidget {
  final bool isNewCategory;
  const CreateNewNotePage({super.key, required this.isNewCategory});

  @override
  State<CreateNewNotePage> createState() => _CreateNewNotePageState();
}

class _CreateNewNotePageState extends State<CreateNewNotePage> {
  List<String> categories = [];
  final NoteService noteService = NoteService();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitleCotroller = TextEditingController();
  final TextEditingController _noteContentCotroller = TextEditingController();
  final TextEditingController _noteCategoryCotroller = TextEditingController();
  String category = 'Work';

  void dispose() {
    _noteTitleCotroller.dispose();
    _noteContentCotroller.dispose();
    _noteCategoryCotroller.dispose();

    super.dispose();
  }

  Future _loadCategories() async {
    categories = await noteService.getAllCategories();

    setState(() {
      print(categories.length);
    });
  }

  @override
  void initState() {
    _loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create New Note",
          style: AppTextStyles.appSubtitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppConstants.kDefaultPadding / 2,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    widget.isNewCategory
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: _noteCategoryCotroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a category';
                                }
                                return null;
                              },
                              style: TextStyle(
                                color: AppColors.kWhiteColor,
                                fontFamily: GoogleFonts.outfit().fontFamily,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                hintText: 'New Category',
                                hintStyle: TextStyle(
                                  color: AppColors.kWhiteColor.withOpacity(0.5),
                                  fontFamily: GoogleFonts.outfit().fontFamily,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppConstants.kDefaultPadding),
                                  borderSide: BorderSide(
                                    color:
                                        AppColors.kWhiteColor.withOpacity(0.1),
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppConstants.kDefaultPadding),
                                  borderSide: BorderSide(
                                    color: AppColors.kWhiteColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),

                            // add category dropdown menu
                            child: DropdownButtonFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Select a category';
                                }
                                return null;
                              },
                              style: TextStyle(
                                color: AppColors.kWhiteColor,
                                fontFamily: GoogleFonts.outfit().fontFamily,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                              isExpanded: false,
                              hint: const Text(
                                'Category',
                              ),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color:
                                        AppColors.kWhiteColor.withOpacity(0.1),
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: AppColors.kWhiteColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                              items: categories.map((String category) {
                                return DropdownMenuItem<String>(
                                  alignment: Alignment.centerLeft,
                                  value: category,
                                  child: Text(
                                    category,
                                    style: AppTextStyles.appButton,
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {},
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),

                    //note title
                    TextFormField(
                      controller: _noteTitleCotroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 30,
                      ),
                      decoration: InputDecoration(
                        hintText: "Note Title",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 35,
                        ),
                        // Remove all borders
                        border: InputBorder.none,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //note content

                    TextFormField(
                      controller: _noteContentCotroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a content';
                        }
                        return null;
                      },
                      maxLines: 12,
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        hintText: "Content",
                        hintStyle: TextStyle(
                            color: AppColors.kWhiteColor.withOpacity(0.5),
                            fontSize: 20,
                            fontWeight: FontWeight.w200),
                        // Remove all borders
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: AppColors.kWhiteColor.withOpacity(0.2),
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // add the button
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: const WidgetStatePropertyAll(
                                AppColors.kFabColor),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                          onPressed: () {
                            //save the note
                            if (_formKey.currentState!.validate()) {
                              try {
                                final NoteService noteService = NoteService();
                                noteService.addNewNote(
                                  NoteModals(
                                    title: _noteTitleCotroller.text,
                                    category: widget.isNewCategory
                                        ? _noteCategoryCotroller.text
                                        : category,
                                    content: _noteContentCotroller.text,
                                    date: DateTime.now(),
                                    id: const Uuid().v4(),
                                  ),
                                );

                                // snack bar
                                AppHelpers.showSnackBar(
                                    context, "Note Saved Succesfully!");
                                _noteContentCotroller.clear();
                                _noteTitleCotroller.clear();
                                RouterClass.router.go("/notes");
                              } catch (e) {
                                AppHelpers.showSnackBar(
                                    context, "Note save failed!");
                              }
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Save Note",
                              style: AppTextStyles.appButton,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
