import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/pages/assignment_page.dart';
import 'package:flutter_app4_uninotemaster/pages/homepage.dart';
import 'package:flutter_app4_uninotemaster/pages/note_page.dart';
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
      )
    ],
  );
}
