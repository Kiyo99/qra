import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/course/course_model.dart';
import 'package:qra/presentation/widgets/app_dialogs.dart';
import 'package:qra/presentation/widgets/prompts.dart';

class StudentDelegate extends SearchDelegate<Map<String, dynamic>> {
  @override
  List<Widget>? buildActions(BuildContext context) =>
      [const SizedBox(width: 20)];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
          titleTextStyle: GoogleFonts.exo2(),
          elevation: 0),
    );
  }

  @override
  String get searchFieldLabel => 'Course code ...';

  @override
  Widget? buildLeading(BuildContext context) => const BackButton();

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
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
                  Expanded(
                    child: Text(
                      "Well that didn't go as planned, please try again later",
                      style: GoogleFonts.exo2(fontSize: 18),
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
                  Expanded(
                    child: Text(
                      "Yikes! Looks like you haven't searched for a course yet",
                      style: GoogleFonts.exo2(fontSize: 18),
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
              final auth = FirebaseAuth.instance;
              final _fireStore = FirebaseFirestore.instance;
              Map<String, dynamic> data =
                  documentSnapshot.data()! as Map<String, dynamic>;
              final course = CourseModel.fromJson(data);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  title: Text(course.courseName, style: GoogleFonts.exo2()),
                  subtitle:
                      Text(course.courseCode, style: GoogleFonts.exo2()),
                  onTap: () async {
                    // print("Entry: ${auth.currentUser}");
                    final studentsDoc = await _fireStore
                        .collection("Users")
                        .doc(auth.currentUser!.email.toString())
                        .get();

                    await _fireStore
                        .collection("Courses")
                        .doc(course.courseCode)
                        .update({
                          "students": FieldValue.arrayUnion([
                            studentsDoc.data()!,
                          ])
                        })
                        .whenComplete(
                          () => Constants.showToast(context,
                              'Successfully subscribed to ${course.courseName}'),
                        )
                        .onError((error, stackTrace) => Constants.showToast(context,
                            'Failed to subscribe to ${course.courseName}'));
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
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
                  Expanded(
                    child: Text(
                      "Hmm, can't seem find that course",
                      style: GoogleFonts.exo2(fontSize: 18),
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
              child: ListView(
                children: [
                  Transform.scale(
                    scale: 0.70,
                    child: Lottie.asset(
                      "assets/lottie/search.json",
                      frameRate: FrameRate(60),
                    ),
                  ),
                  Text(
                    "Remember to search by course codes ... happy searching!",
                    style: GoogleFonts.exo2(fontSize: 18),
                    textAlign: TextAlign.center,
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
              final auth = FirebaseAuth.instance;
              final _fireStore = FirebaseFirestore.instance;
              Map<String, dynamic> data =
                  documentSnapshot.data()! as Map<String, dynamic>;
              final course = CourseModel.fromJson(data);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  title: Text(course.courseName, style: GoogleFonts.exo2()),
                  subtitle:
                      Text(course.courseCode, style: GoogleFonts.exo2()),
                  onTap: () async {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      isScrollControlled: true,
                      builder: (ctx) => AppPrompts(
                        asset: 'assets/lottie/warning.json',
                        primaryAction: () async {
                          Get.back();
                          AppDialogs.lottieLoader();
                          // print("Entry: ${auth.currentUser}");
                          final studentsDoc = await _fireStore
                              .collection("Users")
                              .doc(auth.currentUser!.email.toString())
                              .get();

                          await _fireStore
                              .collection("Courses")
                              .doc(course.courseCode)
                              .update({
                            "students": FieldValue.arrayUnion([
                              studentsDoc.data()!,
                            ])
                          }).whenComplete(() {
                            Get.back();
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0),
                                ),
                              ),
                              isScrollControlled: true,
                              builder: (ctx) => AppPrompts(
                                asset: 'assets/lottie/success.json',
                                primaryAction: () {
                                  Get.back();
                                },
                                message:
                                    'You have successfully subscribed to ${course.courseName}, good luck in your exams!',
                                title: 'Success',
                                showSecondary: false,
                                buttonText: 'Okay',
                              ),
                            );
                          }).onError((error, stackTrace) => () {
                                    Get.back();
                                    Constants.showToast(context,
                                        'Failed to subscribe to ${course.courseName}');
                                  });
                        },
                        message:
                            'Are you sure you want to subscribe to ${course.courseName}?',
                        title: 'Subscribe?',
                        showSecondary: true,
                        buttonText: 'Yes, subscribe',
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}