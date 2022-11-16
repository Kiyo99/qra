import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/course/course_model.dart';
import 'package:qra/data/student_model/student_model.dart';
import 'package:qra/presentation/widgets/app_dialogs.dart';
import 'package:qra/presentation/widgets/app_modal.dart';
import 'package:qra/presentation/widgets/prompts.dart';

class SubscribedCoursesScreen extends HookWidget {
  static const id = "/subscribed_courses_screen";

  SubscribedCoursesScreen({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _courseStream =
      FirebaseFirestore.instance.collection("Users").snapshots();

  @override
  Widget build(BuildContext context) {
    final args = useState<StudentModel>(Get.arguments);
    final studentData = args.value;
    final courses = studentData.courses;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscribed courses"),
        titleTextStyle: GoogleFonts.exo2(fontSize: 20),
        elevation: 0,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: courses!.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(courses[index].courseName, style: GoogleFonts.exo2()),
                  const SizedBox(height: 10),
                  Text(courses[index].courseCode, style: GoogleFonts.exo2()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: 'Got it', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
