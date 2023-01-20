import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/course/course_model.dart';
import 'package:qra/presentation/staff/courses/filter_view.dart';
import 'package:qra/presentation/widgets/build_course_card.dart';

class ViewCoursesScreen extends HookWidget {
  static const id = "/view_course_screen";

  const ViewCoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = useState("courseName");
    final filterBy = useState("All");
    final Stream<QuerySnapshot> _courseStream = FirebaseFirestore.instance
        .collection("Courses")
        .orderBy(filter.value)
        .snapshots();
    return Scaffold(
        appBar: AppBar(
          title: Text("View courses",
              style: GoogleFonts.exo2(fontWeight: FontWeight.bold)),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    isScrollControlled: true,
                    builder: (ctx) => FilterView(
                      allFunction: () {
                        filterBy.value = "All";
                        Get.back();
                      },
                      todayFunction: () {
                        filterBy.value = "Today";
                        Get.back();
                      },
                      tomorrowFunction: () {
                        filterBy.value = "Tomorrow";
                        Get.back();
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.sort_outlined,
                )),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _courseStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Constants.coolOrange,
              ));
            }

            if (snapshot.data?.size == 0) {
              return const Center(
                child: Text(
                  "No courses yet. Check in later",
                  style: TextStyle(fontSize: 20),
                ),
              );
            }

            List<CourseModel> allCourses =
                snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
              Map<String, dynamic> data =
                  documentSnapshot.data()! as Map<String, dynamic>;
              final course = CourseModel.fromJson(data);
              return course;
            }).toList();

            List<CourseModel> todayCourses = allCourses
                .where((e) =>
                    e.dueDate ==
                    DateFormat('yyyy-MM-dd').format(DateTime.now()))
                .toList();

            List<CourseModel> tomorrowCourses = allCourses
                .where((e) =>
                    e.dueDate ==
                    DateFormat('yyyy-MM-dd')
                        .format(DateTime.now().add(const Duration(days: 1))))
                .toList();

            return filterBy.value == "All"
                ? BuildCourseCard(courses: allCourses)
                : filterBy.value == "Today"
                    ? BuildCourseCard(courses: todayCourses)
                    : BuildCourseCard(courses: tomorrowCourses);
          },
        ));
  }
}
