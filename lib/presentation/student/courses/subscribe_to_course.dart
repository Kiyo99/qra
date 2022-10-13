import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/course/course_model.dart';
import 'package:qra/data/fb_student_model/student_model.dart';
import 'package:qra/presentation/widgets/staff_delegate.dart';
import 'package:qra/presentation/widgets/search_button.dart';

class SubscribeToCourseScreen extends HookWidget {
  static const id = "/subscribe_to_course_screen";

  SubscribeToCourseScreen({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _courseStream =
      FirebaseFirestore.instance.collection("Courses").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.coolBlue,
        appBar: AppBar(
          title: const Text("Subscribe to a course"),
          backgroundColor: Constants.coolBlue,
          elevation: 0,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _courseStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              children:
                  snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
                Map<String, dynamic> data =
                    documentSnapshot.data()! as Map<String, dynamic>;
                final course = CourseModel.fromJson(data);

                return ListTile(
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
                );
              }).toList(),
            );
          },
        ));
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
