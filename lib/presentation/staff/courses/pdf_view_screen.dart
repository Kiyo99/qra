import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:printing/printing.dart';
import 'package:qra/data/course/course_model.dart';
import 'package:qra/data/student_model/student_model.dart';

class PdfViewScreen extends HookWidget {
  static const id = "pdf_view_screen";

  const PdfViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final course = useState<CourseModel>(Get.arguments);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: PdfPreview(
          canChangeOrientation: false,
          canChangePageFormat: false,
          canDebug: false,
          pdfFileName: "${course.value.courseName} attendance.pdf",
          previewPageMargin: const EdgeInsets.all(5),
          loadingWidget: Center(
            child: Transform.scale(
              scale: 0.5,
              child: Lottie.asset(
                "assets/lottie/loader.json",
                frameRate: FrameRate(60),
              ),
            ),
          ),
          build: (format) => generateDocument(format, course.value),
        ),
      ),
    );
  }

  Future<Uint8List> generateDocument(
      PdfPageFormat format, CourseModel course) async {
    final doc = pdf.Document();

    final font2 = await PdfGoogleFonts.openSansBold();

    doc.addPage(
      pdf.MultiPage(
          build: (context) => [
                pdf.Text(
                  "${course.courseName} Attendance List",
                  style: pdf.TextStyle(
                      fontSize: 20,
                      fontWeight: pdf.FontWeight.bold,
                      font: font2),
                ),
                pdf.SizedBox(height: 15),
                buildTable(course),
                pdf.SizedBox(height: 20),
                pdf.Text(
                  "Total number of students: ${course.students?.length}",
                  style: pdf.TextStyle(
                      fontWeight: pdf.FontWeight.bold, font: font2),
                ),
              ]),
    );
    return await doc.save();
  }

  static pdf.Table buildTable(CourseModel course) {
    final headers = [
      // pdf.Text(
      //   "Index",
      //   style: pdf.TextStyle(
      //       fontWeight: pdf.FontWeight.bold, fontSize: 18, font: font1),
      // ),

      "Full name", "ID", "Eligible", "Date"

      // pdf.Text(
      //   "ID",
      //   style: pdf.TextStyle(
      //     fontWeight: pdf.FontWeight.bold,
      //     fontSize: 18,
      //   ),
      // ),
      // pdf.Text(
      //   "Eligible",
      //   style: pdf.TextStyle(
      //     fontWeight: pdf.FontWeight.bold,
      //     fontSize: 18,
      //   ),
      // ),
      // pdf.Text(
      //   "Date",
      //   style: pdf.TextStyle(
      //     fontWeight: pdf.FontWeight.bold,
      //     fontSize: 18,
      //   ),
      // ),
    ];

    final data = course.students!.map((e) {
      final std = StudentModel.fromJson(e);
      return [
        std.fullName,
        std.iD,
        std.isEligible == "true" ? 'Eligible' : 'Not Eligible',
        DateTime.now(),
      ];
    }).toList();

    return pdf.Table.fromTextArray(
      headers: headers,
      data: data,
    );
  }
}
