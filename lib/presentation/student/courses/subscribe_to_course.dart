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

class SubscribeToCourseScreen extends HookWidget {
  static const id = "/subscribe_to_course_screen";

  SubscribeToCourseScreen({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _courseStream = FirebaseFirestore.instance
      .collection("Courses")
      .orderBy("courseName")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Subscribe to a course"),
          titleTextStyle: GoogleFonts.exo2(fontSize: 20),
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
              return Center(
                  child:
                      CircularProgressIndicator(color: Constants.coolOrange));
            }
            return ListView(
              physics: const BouncingScrollPhysics(),
              children:
                  snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
                Map<String, dynamic> data =
                    documentSnapshot.data()! as Map<String, dynamic>;
                final course = CourseModel.fromJson(data);

                return GestureDetector(
                  onTap: () async {
                    AppModal.showModal(
                      context: context,
                      asset: 'assets/lottie/warning.json',
                      primaryAction: () async {
                        Get.back();
                        AppDialogs.lottieLoader();
                        // print("Entry: ${auth.currentUser}");
                        final studentsDoc = await _fireStore
                            .collection("Users")
                            .doc(auth.currentUser!.email.toString())
                            .get();

                        final student =
                            StudentModel.fromJson(studentsDoc.data()!);

                        if (student.courses != null) {
                          final f = student.courses!.where((element) =>
                              element.courseCode == course.courseCode);
                          if (f.isNotEmpty) {
                            if (f.first.courseCode == course.courseCode) {
                              Get.back();
                              AppModal.showModal(
                                context: context,
                                title: "Already subscribed 😕",
                                message:
                                    "You've already subscribed to this course",
                                asset: "assets/lottie/error.json",
                                primaryAction: () => Get.back(),
                                buttonText: "Okay",
                              );
                              return;
                            }
                          }
                        }

                        await _fireStore
                            .collection("Courses")
                            .doc(course.courseCode)
                            .update({
                          "students": FieldValue.arrayUnion([
                            studentsDoc.data()!,
                          ])
                        }).whenComplete(() async {
                          final studentCourse = CourseModel(
                              courseName: course.courseName,
                              courseCode: course.courseCode,
                              dueDate: course.dueDate,
                              teacher: course.teacher,
                              attended: "false");
                          await _fireStore
                              .collection("Users")
                              .doc(auth.currentUser!.email.toString())
                              .update({
                            "courses": FieldValue.arrayUnion([
                              studentCourse.toJson(),
                            ]),
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
                          });
                        }).onError((error, stackTrace) => Constants.showToast(
                                context,
                                'Failed to subscribe to ${course.courseName}'));
                      },
                      message:
                          'Are you sure you want to subscribe to ${course.courseName}?',
                      title: 'Subscribe?',
                      showSecondary: true,
                      buttonText: 'Yes, subscribe',
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 10, top: 10),
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
                        Text(course.courseName, style: GoogleFonts.exo2()),
                        const SizedBox(height: 10),
                        Text(course.courseCode, style: GoogleFonts.exo2()),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}
