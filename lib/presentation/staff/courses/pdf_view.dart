import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:printing/printing.dart';
import 'package:qra/data/course/course_model.dart';
import 'package:qra/data/student_model/student_model.dart';

class PdfView extends HookWidget {
  static const id = "pdf_view";

  const PdfView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final course = useState<CourseModel>(Get.arguments);
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: PdfPreview(
        build: (format) => generateDocument(format, course.value),
      ),
    );
  }

  Future<Uint8List> generateDocument(
      PdfPageFormat format, CourseModel course) async {
    final doc = pdf.Document();

    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();

    doc.addPage(
      pdf.Page(
          pageTheme: pdf.PageTheme(
            pageFormat: format.copyWith(
              marginBottom: 0,
              marginLeft: 0,
              marginRight: 0,
              marginTop: 0,
            ),
            orientation: pdf.PageOrientation.portrait,
            theme: pdf.ThemeData.withFont(
              base: font1,
              bold: font2,
            ),
          ),
          build: (context) {
            return pdf.Container(
              padding: const pdf.EdgeInsets.all(20),
              child: pdf.Column(
                children: [
                  pdf.Text(
                    "${course.courseName} Attendance List",
                    style: pdf.TextStyle(
                        fontSize: 24,
                        fontWeight: pdf.FontWeight.bold,
                        font: font2),
                  ),
                  pdf.SizedBox(height: 15),
                  pdf.Table(
                    children: [
                      pdf.TableRow(
                        children: [
                          pdf.Text(
                            "Index",
                            style: pdf.TextStyle(
                                fontWeight: pdf.FontWeight.bold,
                                fontSize: 18,
                                font: font1),
                          ),
                          pdf.Text(
                            "Full name",
                            style: pdf.TextStyle(
                                fontWeight: pdf.FontWeight.bold,
                                fontSize: 18,
                                font: font1),
                          ),
                          pdf.Text(
                            "ID",
                            style: pdf.TextStyle(
                                fontWeight: pdf.FontWeight.bold,
                                fontSize: 18,
                                font: font1),
                          ),
                          pdf.Text(
                            "Eligible",
                            style: pdf.TextStyle(
                                fontWeight: pdf.FontWeight.bold,
                                fontSize: 18,
                                font: font1),
                          ),
                          pdf.Text(
                            "Date",
                            style: pdf.TextStyle(
                                fontWeight: pdf.FontWeight.bold,
                                fontSize: 18,
                                font: font1),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pdf.ListView.builder(
                    itemBuilder: (context, index) {
                      final studentModel =
                          StudentModel.fromJson(course.students![index]);
                      return pdf.Container(
                        child: pdf.Table(
                          children: [
                            pdf.TableRow(
                              children: [
                                pdf.Text("${index + 1}",
                                    style: const pdf.TextStyle(fontSize: 18)),
                                pdf.Text(
                                  studentModel.fullName,
                                  style: pdf.TextStyle(
                                      fontWeight: pdf.FontWeight.bold,
                                      fontSize: 18,
                                      font: font1),
                                ),
                                pdf.Text(
                                  studentModel.iD,
                                  style: pdf.TextStyle(
                                      fontWeight: pdf.FontWeight.bold,
                                      fontSize: 18,
                                      font: font1),
                                ),
                                pdf.Text(
                                  studentModel.isEligible == "true"
                                      ? "Eligible"
                                      : "Not Eligible",
                                  style: pdf.TextStyle(
                                      fontWeight: pdf.FontWeight.bold,
                                      fontSize: 18,
                                      font: font1),
                                ),
                                pdf.Text("10/02/2023}",
                                    style: const pdf.TextStyle(fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: course.students!.length,
                  ),
                ],
              ),
            );

            // return pdf.Container(
            //   padding: const pdf.EdgeInsets.all(20),
            //   child: pdf.Column(
            //     children: [
            //       pdf.Text(
            //         "${course.courseName} Attendance List",
            //         style: pdf.TextStyle(
            //             fontSize: 24,
            //             fontWeight: pdf.FontWeight.bold,
            //             font: font2),
            //       ),
            //       pdf.SizedBox(height: 15),
            //       pdf.ListView.builder(
            //         itemBuilder: (context, index) {
            //           final studentModel =
            //               StudentModel.fromJson(course.students![index]);
            //           return pdf.Container(
            //             margin: const pdf.EdgeInsets.only(bottom: 10),
            //             child: pdf.Row(
            //               children: [
            //                 pdf.Text("${index + 1}",
            //                     style: const pdf.TextStyle(fontSize: 14)),
            //                 pdf.SizedBox(width: 15),
            //                 pdf.Column(children: [
            //                   pdf.Text(
            //                     studentModel.fullName,
            //                     style: pdf.TextStyle(
            //                         fontWeight: pdf.FontWeight.bold,
            //                         fontSize: 18,
            //                         font: font1),
            //                   ),
            //                   pdf.SizedBox(width: 5),
            //                   pdf.Row(
            //                     children: [
            //                       pdf.Text(
            //                         studentModel.iD,
            //                         style: pdf.TextStyle(
            //                           fontSize: 18,
            //                           font: font1,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ])
            //               ],
            //             ),
            //           );
            //         },
            //         itemCount: course.students!.length,
            //       ),
            //     ],
            //   ),
            // );
          }),
    );
    return await doc.save();
  }
}
