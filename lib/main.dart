import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/utils/router_pages.dart';
import 'package:flutter_app4_uninotemaster/utils/theme_data.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'UniNoteMaster',
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.darkTheme.copyWith(
        textTheme: GoogleFonts.dmSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routerConfig: RouterClass.router,
    );
  }
}
