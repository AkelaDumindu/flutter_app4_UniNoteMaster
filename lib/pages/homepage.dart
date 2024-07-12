import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/utils/constant.dart';
import 'package:flutter_app4_uninotemaster/utils/router_pages.dart';
import 'package:flutter_app4_uninotemaster/utils/text_style.dart';
import 'package:flutter_app4_uninotemaster/widget/note_todo_card.dart';
import 'package:flutter_app4_uninotemaster/widget/progress_card.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "UniNoteMaster",
          style: AppTextStyles.appTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const ProgressCard(
              completedTask: 2,
              totalTask: 5,
            ),
            const SizedBox(
              height: AppConstants.kDefaultPadding * 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // go ot the notes page
                    RouterClass.router.push("/notes");
                  },
                  child: const NoteTodoCard(
                    title: "Notes",
                    description: "3 notes",
                    icon: Icons.bookmark_add_outlined,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // go to the assignment page
                    RouterClass.router.push("/assignment");
                  },
                  child: const NoteTodoCard(
                    title: "Assignment",
                    description: "3 Tasks",
                    icon: Icons.today_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppConstants.kDefaultPadding * 1.5,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Progress",
                  style: AppTextStyles.appSubtitle,
                ),
                Text(
                  "See All",
                  style: AppTextStyles.appButton,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
