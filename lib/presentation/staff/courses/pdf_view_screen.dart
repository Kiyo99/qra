import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:printing/printing.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/course/course_model.dart';
import 'package:qra/data/student_model/student_model.dart';

class PdfViewScreen extends HookWidget {
  static const id = "pdf_view_screen";

  const PdfViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final course = useState<CourseModel>(Get.arguments);
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PDF Preview of ${course.value.courseCode}",
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Get.back();
          },
          color: Colors.white,
        ),
        foregroundColor: Colors.white,
        backgroundColor:
            brightness == Brightness.dark ? Constants.coolBlue : Colors.blue,
      ),
      body: PdfPreview(
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        scrollViewDecoration: BoxDecoration(color: Constants.coolWhite),
        pdfPreviewPageDecoration: BoxDecoration(
          color: Constants.coolWhite,
        ),
        pdfFileName: "${course.value.courseName} attendance.pdf",
        previewPageMargin: const EdgeInsets.all(0),
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
                  course.students == null
                      ? "Total number of students: 0"
                      : "Total number of students: ${course.students?.length}",
                  style: pdf.TextStyle(
                      fontWeight: pdf.FontWeight.bold, font: font2),
                ),
              ]),
    );
    return await doc.save();
  }

  static pdf.Table buildTable(CourseModel course) {
    final headers = ["Full name", "ID", "Eligible", "Attended", "Date"];

    if (course.students == null) {
      final data = [
        [
          "",
          "",
          "",
          "",
        ]
      ];

      return pdf.Table.fromTextArray(
        headers: headers,
        data: data,
      );
    } else {
      final data = course.students!.map((e) {
        final std = StudentModel.fromJson(e);
        final dateFormat = DateFormat('yyyy-MM-dd');

        //todo: attack each student attendance

        return [
          std.fullName,
          std.iD,
          std.isEligible == "true" ? 'Eligible' : 'Not Eligible',
          std.attended == "true" ? 'Yes' : 'No',
          dateFormat.format(DateTime.now())
        ];
      }).toList();

      return pdf.Table.fromTextArray(
        headers: headers,
        data: data,
      );
    }
  }
}
