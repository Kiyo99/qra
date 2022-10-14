import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/course/course_model.dart';
import 'package:qra/presentation/staff/courses/view_course_details.dart';

class StaffDelegate extends SearchDelegate<Map<String, dynamic>> {
  @override
  List<Widget>? buildActions(BuildContext context) =>
      [const SizedBox(width: 20)];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        fillColor: Constants.coolBlue,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
          color: Constants.coolBlue,
          shadowColor: Constants.coolBlue,
          elevation: 0),
    );
  }

  @override
  String get searchFieldLabel => 'Course code ...';

  @override
  Widget? buildLeading(BuildContext context) => const BackButton();

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Constants.coolBlue,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Courses').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');

          final results = snapshot.data!.docs.where((DocumentSnapshot a) {
            return a['courseCode'].toString().contains(query.toUpperCase());
          });

          if (results.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Transform.scale(
                      scale: 0.60,
                      child: Lottie.asset(
                        "assets/lottie/search_not_found.json",
                        frameRate: FrameRate(60),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "Well that didn't go as planned, please try again later",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (query.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Transform.scale(
                      scale: 0.70,
                      child: Lottie.asset(
                        "assets/lottie/empty_box.json",
                        frameRate: FrameRate(60),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "Yikes! Looks like you haven't searched for a course yet",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Container(
            margin: const EdgeInsets.only(top: 10),
            child: ListView(
              children: results.map((DocumentSnapshot documentSnapshot) {
                Map<String, dynamic> data =
                    documentSnapshot.data()! as Map<String, dynamic>;
                final course = CourseModel.fromJson(data);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        // color: const Color.fromRGBO(64, 75, 96, .9),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(course.courseName),
                        subtitle: Text(course.courseCode),
                        onTap: () {
                          Get.toNamed(ViewCourseDetails.id, arguments: course);
                        },
                      )),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Constants.coolBlue,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Courses').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');

          final results = snapshot.data!.docs.where((DocumentSnapshot a) =>
              a['courseCode'].toString().contains(query.toUpperCase()));

          if (results.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Transform.scale(
                      scale: 0.70,
                      child: Lottie.asset(
                        "assets/lottie/search_error_demo.json",
                        frameRate: FrameRate(60),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "Hmm, can't seem find that course",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (query.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 0.70,
                    child: Lottie.asset(
                      "assets/lottie/search.json",
                      frameRate: FrameRate(60),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      "Remember to search by course codes ... happy searching!",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          }

          return Container(
            margin: const EdgeInsets.only(top: 10),
            child: ListView(
              children: results.map((DocumentSnapshot documentSnapshot) {
                Map<String, dynamic> data =
                    documentSnapshot.data()! as Map<String, dynamic>;
                final course = CourseModel.fromJson(data);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        // color: const Color.fromRGBO(64, 75, 96, .9),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(course.courseName),
                        subtitle: Text(course.courseCode),
                        onTap: () {
                          Get.toNamed(ViewCourseDetails.id, arguments: course);
                        },
                      )),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
