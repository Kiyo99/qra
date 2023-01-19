import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qra/data/course/course_model.dart';
import 'package:qra/data/scanner/scanner_model.dart';
import 'package:qra/presentation/widgets/app_modal.dart';
import 'package:qra/presentation/widgets/prompts.dart';

class QrScanner extends HookConsumerWidget {
  static const id = "scanner";

  final _fireStore = FirebaseFirestore.instance;

  QrScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseCode = Get.arguments;

    return MobileScanner(
        allowDuplicates: false,
        onDetect: (barcode, args) async {
          if (barcode.rawValue == null) {
            debugPrint('Failed to scan Barcode');
          } else {
            final String code = barcode.rawValue!;
            debugPrint('Barcode found! $code');
            final decodedCourse = json.decode(code);

            final codd = ScannerModel.fromJson(decodedCourse);
            debugPrint('Barcodeeee found! ${codd}');
            debugPrint('Nameee found! ${codd.name}');
            debugPrint('Idd found! ${codd.iD}');
            debugPrint('Eligible found! ${codd.eligible}');
            debugPrint('courses! ${codd.courses}');

            final registeredCourses = codd.courses;
            if (registeredCourses == null) {
              Get.back();
              AppModal.showModal(
                context: context,
                title: "Error",
                message: "${codd.name} hasn't registered for any exams",
                asset: "assets/lottie/error.json",
                primaryAction: () {
                  Get.back();
                },
                buttonText: "Okay",
                showSecondary: false,
              );
              return;
            }

            final possibleCourse = registeredCourses
                .where((course) => course.courseCode == courseCode);

            if (possibleCourse.isEmpty) {
              Get.back();
              AppModal.showModal(
                context: context,
                title: "Error",
                message: "${codd.name} did not register for this exam",
                asset: "assets/lottie/error.json",
                primaryAction: () {
                  Get.back();
                },
                buttonText: "Okay",
                showSecondary: false,
              );
              return;
            }

            //todo do not forget to change the codd.is == true
            if (possibleCourse.isNotEmpty && codd.eligible == "false") {
              Get.back();

              AppModal.showModal(
                context: context,
                title: "Success",
                message: "${codd.name} is eligible to take this exam",
                asset: "assets/lottie/success.json",
                primaryAction: () {
                  Get.back();
                },
                buttonText: "Okay",
                showSecondary: false,
              );

              final courseDoc =
                  await _fireStore.collection("Courses").doc(courseCode).get();
              final courseModel = CourseModel.fromJson(
                  courseDoc.data() as Map<String, dynamic>);
              final studentDoc = courseModel.students;

              final studentToUpdate =
                  studentDoc?.firstWhere((student) => student['iD'] == codd.iD);

              studentToUpdate['attended'] = "true";

              studentDoc?.removeWhere((student) => student['iD'] == codd.iD);
              studentDoc?.add(studentToUpdate);

              await _fireStore
                  .collection("Courses")
                  .doc(courseCode)
                  .update({"students": FieldValue.delete()});

              //todo: Handle errors with loaders

              await _fireStore.collection("Courses").doc(courseCode).update({
                "students": FieldValue.arrayUnion(studentDoc!),
              });
            }

            if (possibleCourse.isNotEmpty && codd.eligible == "true") {
              Get.back();
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0))),
                builder: (ctx) => AppPrompts(
                    title: "Failure",
                    message: "${codd.name} is not eligible to take this exam",
                    asset: "assets/lottie/error.json",
                    primaryAction: () {
                      Get.back();
                    },
                    buttonText: "Okay",
                    showSecondary: false),
              );
              return;
            }
          }
        });
  }
}
