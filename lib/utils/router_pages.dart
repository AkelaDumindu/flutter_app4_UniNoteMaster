import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/modals/note_modals.dart';
import 'package:flutter_app4_uninotemaster/pages/assignment_page.dart';
import 'package:flutter_app4_uninotemaster/pages/create_new_note.dart';
import 'package:flutter_app4_uninotemaster/pages/homepage.dart';
import 'package:flutter_app4_uninotemaster/pages/note_by_category.dart';
import 'package:flutter_app4_uninotemaster/pages/note_page.dart';
import 'package:flutter_app4_uninotemaster/pages/update_note.dart';
import 'package:go_router/go_router.dart';

class RouterClass {
  static final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: [
      // homepage

      GoRoute(
        name: "home",
        path: "/",
        builder: (context, state) {
          return const Homepage();
        },
      ),

      //notes

      GoRoute(
        name: "notes",
        path: "/notes",
        builder: (context, state) {
          return const NotePage();
        },
      ),

      //assignment
      GoRoute(
        name: "assignment",
        path: "/assignment",
        builder: (context, state) {
          return const AssignmentPage();
        },
      ),

      // category page
      GoRoute(
        name: "category",
        path: "/category",
        builder: (context, state) {
          final String category = state.extra as String;
          return NoteByCategory(category: category);
        },
      ),

      // create new category
      GoRoute(
        name: "create-note",
        path: "/create-note",
        builder: (context, state) {
          final isNewCategoryPage = state.extra as bool;
          return CreateNewNotePage(
            isNewCategory: isNewCategoryPage,
          );
        },
      ),

      //edit note page
      GoRoute(
        name: "edit-note",
        path: "/edit-note",
        builder: (context, state) {
          final NoteModals note = state.extra as NoteModals;
          return UpdateNote(
            note: note,
          );
        },
      )
    ],
  );
}
