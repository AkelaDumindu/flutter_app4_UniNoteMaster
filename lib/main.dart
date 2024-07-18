import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/modals/assignment_modals.dart';
import 'package:flutter_app4_uninotemaster/modals/note_modals.dart';
import 'package:flutter_app4_uninotemaster/pages/assignment_data_inherited.dart';
import 'package:flutter_app4_uninotemaster/utils/router_pages.dart';
import 'package:flutter_app4_uninotemaster/utils/theme_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  // initilize hive
  await Hive.initFlutter();

  // register the adaptors
  Hive.registerAdapter(NoteModalsAdapter());
  Hive.registerAdapter(AssignmentModalsAdapter());

//create boxes (boxes like a table)
  await Hive.openBox('notes');
  await Hive.openBox('ass');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AssignmentData(
      assignmentData: [],
      onAssignmentChange: () {},
      child: MaterialApp.router(
        title: 'UniNoteMaster',
        debugShowCheckedModeBanner: false,
        theme: ThemeClass.darkTheme.copyWith(
          textTheme: GoogleFonts.dmSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        routerConfig: RouterClass.router,
      ),
    );
  }
}
