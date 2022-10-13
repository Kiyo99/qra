import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/course/course_model.dart';
import 'package:qra/presentation/staff/courses/view_course_details.dart';

class StudentDelegate extends SearchDelegate<Map<String, dynamic>> {
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
            return const Center(
              child: Text(
                  "Well that didn't go as planned, please try again later"),
            );
          }

          if (query.isEmpty) {
            return const Center(
              child: Text(
                  "Yikes! Looks like you haven't searched for a course yet"),
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
                    title: Text(course.courseName),
                    subtitle: Text(course.courseCode),
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
                            () => _showToast(context,
                            'Successfully subscribed to ${course.courseName}'),
                      )
                          .onError((error, stackTrace) => _showToast(context,
                          'Failed to subscribe to ${course.courseName}'));
                    },
                  ),
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
            return const Center(
              child: Text("Hmm, Can't seem to find that course"),
            );
          }

          if (query.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Remember to search by course codes ... happy searching!",
                  textAlign: TextAlign.center,
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
                    title: Text(course.courseName),
                    subtitle: Text(course.courseCode),
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
                            () => _showToast(context,
                                'Successfully subscribed to ${course.courseName}'),
                          )
                          .onError((error, stackTrace) => _showToast(context,
                              'Failed to subscribe to ${course.courseName}'));
                    },
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
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
