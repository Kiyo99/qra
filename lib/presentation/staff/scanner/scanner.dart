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
        onDetect: (capture){},
        // onDetect: (barcode, args) async {
        //   if (barcode.rawValue == null) {
        //     debugPrint('Failed to scan Barcode');
        //   } else {
        //     final String code = barcode.rawValue!;
        //     debugPrint('Barcode found! $code');
        //     final decodedCourse = json.decode(code);
        //
        //     final scannedCourse = ScannerModel.fromJson(decodedCourse);
        //     debugPrint('Barcodeeee found! ${scannedCourse}');
        //     debugPrint('Nameee found! ${scannedCourse.name}');
        //     debugPrint('Idd found! ${scannedCourse.iD}');
        //     debugPrint('Eligible found! ${scannedCourse.eligible}');
        //     debugPrint('courses! ${scannedCourse.courses}');
        //
        //     final registeredCourses = scannedCourse.courses;
        //     if (registeredCourses == null) {
        //       Get.back();
        //       AppModal.showModal(
        //         context: context,
        //         title: "Error",
        //         message:
        //             "${scannedCourse.name} hasn't registered for any exams",
        //         asset: "assets/lottie/error.json",
        //         primaryAction: () {
        //           Get.back();
        //         },
        //         buttonText: "Okay",
        //         showSecondary: false,
        //       );
        //       return;
        //     }
        //
        //     final possibleCourse = registeredCourses
        //         .where((course) => course.courseCode == courseCode);
        //
        //     if (possibleCourse.isEmpty) {
        //       Get.back();
        //       AppModal.showModal(
        //         context: context,
        //         title: "Error",
        //         message: "${scannedCourse.name} did not register for this exam",
        //         asset: "assets/lottie/error.json",
        //         primaryAction: () {
        //           Get.back();
        //         },
        //         buttonText: "Okay",
        //         showSecondary: false,
        //       );
        //       return;
        //     }
        //
        //     //todo do not forget to change the codd.is == true
        //     if (possibleCourse.isNotEmpty && scannedCourse.eligible == "true") {
        //       Get.back();
        //
        //       AppModal.showModal(
        //         context: context,
        //         title: "Success",
        //         message: "${scannedCourse.name} is eligible to take this exam",
        //         asset: "assets/lottie/success.json",
        //         primaryAction: () {
        //           Get.back();
        //         },
        //         buttonText: "Okay",
        //         showSecondary: false,
        //       );
        //
        //       final courseDoc =
        //           await _fireStore.collection("Courses").doc(courseCode).get();
        //       final courseModel = CourseModel.fromJson(
        //           courseDoc.data() as Map<String, dynamic>);
        //       final studentDoc = courseModel.students;
        //
        //       final studentToUpdate = studentDoc
        //           ?.firstWhere((student) => student['iD'] == scannedCourse.iD);
        //
        //       studentToUpdate['attended'] = "true";
        //
        //       studentDoc
        //           ?.removeWhere((student) => student['iD'] == scannedCourse.iD);
        //       studentDoc?.add(studentToUpdate);
        //
        //       await _fireStore
        //           .collection("Courses")
        //           .doc(courseCode)
        //           .update({"students": FieldValue.delete()});
        //
        //       //todo: Handle errors with loaders
        //
        //       await _fireStore.collection("Courses").doc(courseCode).update({
        //         "students": FieldValue.arrayUnion(studentDoc!),
        //       });
        //     }
        //
        //     if (possibleCourse.isNotEmpty &&
        //         scannedCourse.eligible == "false") {
        //       Get.back();
        //       showModalBottomSheet(
        //         context: context,
        //         shape: const RoundedRectangleBorder(
        //             borderRadius: BorderRadius.only(
        //                 topLeft: Radius.circular(25.0),
        //                 topRight: Radius.circular(25.0))),
        //         builder: (ctx) => AppPrompts(
        //             title: "Failure",
        //             message:
        //                 "${scannedCourse.name} is not eligible to take this exam",
        //             asset: "assets/lottie/error.json",
        //             primaryAction: () {
        //               Get.back();
        //             },
        //             buttonText: "Okay",
        //             showSecondary: false),
        //       );
        //       return;
        //     }
        //   }
        // },
        );
  }
}
