import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/course/course_model.dart';
import 'package:qra/data/student_model/student_model.dart';
import 'package:qra/presentation/staff/courses/pdf_view_screen.dart';

class ViewCourseDetails extends HookConsumerWidget {
  static const id = "/view_course_details";

  ViewCourseDetails({Key? key}) : super(key: key);

  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final course = useState<CourseModel>(Get.arguments);

    final brightness = Theme.of(context).brightness;
    final fireStoreCourse = useState<Map<String, dynamic>>({});

    Card makeCard(StudentModel studentModel) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: brightness == Brightness.light
                      ? Constants.coolBlue
                      : Constants.coolWhite),
              color: brightness == Brightness.light
                  ? Constants.coolWhite
                  : Constants.secondaryBlue,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            leading: Container(
                padding: const EdgeInsets.only(right: 5.0),
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1.0, color: Colors.white24))),
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  checkColor: Constants.coolBlue,
                  activeColor: Constants.coolOrange,
                  value: studentModel.attended == "true" ? true : false,
                  onChanged: (v) async {
                    final courseDoc = await _fireStore
                        .collection("Courses")
                        .doc(course.value.courseCode)
                        .get();
                    final courseModel = CourseModel.fromJson(
                        courseDoc.data() as Map<String, dynamic>);
                    final studentDoc = courseModel.students;

                    final studentToUpdate = studentDoc?.firstWhere(
                        (student) => student['iD'] == studentModel.iD);
                    studentToUpdate['attended'] = v.toString();

                    studentDoc?.removeWhere(
                        (student) => student['iD'] == studentModel.iD);
                    studentDoc?.add(studentToUpdate);

                    await _fireStore
                        .collection("Courses")
                        .doc(course.value.courseCode)
                        .update({"students": FieldValue.delete()});

                    //todo: Handle errors with loaders

                    await _fireStore
                        .collection("Courses")
                        .doc(course.value.courseCode)
                        .update({
                      "students": FieldValue.arrayUnion(studentDoc!),
                    });
                  },
                )),
            title: Text(
              studentModel.fullName,
              style: GoogleFonts.exo(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(studentModel.iD, style: GoogleFonts.exo()),
                )
              ],
            ),
            // trailing: Icon(Icons.keyboard_arrow_right,
            //     color: Constants.coolOrange, size: 30.0),
            onTap: () {
              // Get.toNamed(StudentDetailPage.id, arguments: studentModel);
            },
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        title: Text(course.value.courseCode),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_outlined),
            onPressed: () {
              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Generate a PDF?"),
                      content: const Text(
                          "Do you want to generate a pdf document of this attendance list?"),
                      actions: [
                        TextButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: brightness == Brightness.light
                                    ? Constants.coolBlue
                                    : Constants.coolWhite),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        TextButton(
                          child: Text(
                            "Generate",
                            style: TextStyle(
                                color: brightness == Brightness.light
                                    ? Constants.coolBlue
                                    : Constants.coolWhite),
                          ),
                          onPressed: () {
                            Get.back();
                            final courseDetails =
                                CourseModel.fromJson(fireStoreCourse.value);

                            Get.toNamed(PdfViewScreen.id,
                                arguments: fireStoreCourse.value.isEmpty
                                    ? course.value
                                    : courseDetails);
                          },
                        )
                      ],
                    );
                  });
            },
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Courses')
              .doc(course.value.courseCode)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Constants.coolOrange,
              ));
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            Map<String, dynamic> data =
                snapshot.data!.data()! as Map<String, dynamic>;
            fireStoreCourse.value = data;
            final courseDetails = CourseModel.fromJson(data);

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: courseDetails.students?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return makeCard(
                    StudentModel.fromJson(courseDetails.students![index]));
              },
            );
          }),
    );
  }
}
