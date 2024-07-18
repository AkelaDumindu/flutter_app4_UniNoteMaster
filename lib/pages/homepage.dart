import 'package:flutter/material.dart';
import 'package:flutter_app4_uninotemaster/modals/assignment_modals.dart';
import 'package:flutter_app4_uninotemaster/modals/note_modals.dart';
import 'package:flutter_app4_uninotemaster/pages/assignment_data_inherited.dart';
import 'package:flutter_app4_uninotemaster/services/assignment_service.dart';
import 'package:flutter_app4_uninotemaster/services/note_service.dart';
import 'package:flutter_app4_uninotemaster/utils/constant.dart';
import 'package:flutter_app4_uninotemaster/utils/router_pages.dart';
import 'package:flutter_app4_uninotemaster/utils/text_style.dart';
import 'package:flutter_app4_uninotemaster/widget/home_screen_assignments_card.dart';
import 'package:flutter_app4_uninotemaster/widget/note_todo_card.dart';
import 'package:flutter_app4_uninotemaster/widget/progress_card.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<NoteModals> allNotes = [];
  List<AssignmentModals> allAss = [];

  @override
  void initState() {
    super.initState();
    _checkIfUserNew();
    setState(() {});
  }

  void _checkIfUserNew() async {
    // Check if the notes box is empty
    final bool isNewUser = await NoteService().isNewUser() ||
        await AssignmentService().isNewUser();

    if (isNewUser) {
      // If the user is new, create the initial notes
      await NoteService().createInitialNotes();
      await AssignmentService().createInitialAssignment();
    }
    _loadNotes();
    _loadAss();
  }

  // load the all notes
  Future<void> _loadNotes() async {
    final List<NoteModals> loadedNotes = await NoteService().loadNote();
    setState(() {
      allNotes = loadedNotes;
    });
  }

  // load the all Assignments
  Future<void> _loadAss() async {
    final List<AssignmentModals> loadedAss =
        await AssignmentService().loadAssignment();
    setState(() {
      allAss = loadedAss;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AssignmentData(
      assignmentData: allAss,
      onAssignmentChange: _loadAss,
      child: Scaffold(
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
              ProgressCard(
                completedTask: allAss.where((ass) => ass.icCompleted).length,
                totalTask: allAss.length,
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
                    child: NoteTodoCard(
                      title: "Notes",
                      description: "${allNotes.length.toString()} notes",
                      icon: Icons.bookmark_add_outlined,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // go to the assignment page
                      RouterClass.router.push("/assignment");
                    },
                    child: NoteTodoCard(
                      title: "Assignment",
                      description: "${allAss.length.toString()} Tasks",
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
              ),
              const SizedBox(height: 20),
              allAss.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "No Assignments for today , Add some Assignments to get started!",
                              style: AppTextStyles.appDescription.copyWith(
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.blue,
                                ),
                              ),
                              onPressed: () {
                                RouterClass.router.push("/assignment");
                              },
                              child: const Text("Add Task"),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: allAss.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: HomeScreenAssignmentsCard(
                              assTitle: allAss[index].title,
                              date: allAss[index].date.toString(),
                              time: allAss[index].time.toString(),
                              isDone: allAss[index].icCompleted,
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
