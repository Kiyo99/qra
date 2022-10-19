import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/course/course_model.dart';
import 'package:qra/data/fb_student_model/student_model.dart';
import 'package:qra/presentation/student/student_details.dart';

class ViewCourseDetails extends HookConsumerWidget {
  static const id = "/view_course_details";

  ViewCourseDetails({Key? key}) : super(key: key);

  final _fireStore = FirebaseFirestore.instance;

  //todo: You will have to accept arguments here

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final course = useState<CourseModel>(Get.arguments);

    Card makeCard(StudentModel studentModel) {
      return Card(
        elevation: 4.0,
        color: Constants.coolBlue,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(
              color: Constants.secondaryBlue,
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
                  value: studentModel.isEligible == "true" ? true : false,
                  onChanged: (v) async {
                    //todo: Get the entire student course list, edit array and resend

                    final courseDoc = await _fireStore
                        .collection("Courses")
                        .doc(course.value.courseCode)
                        .get();
                    final courseModel = CourseModel.fromJson(
                        courseDoc.data() as Map<String, dynamic>);
                    final studentDoc = courseModel.students;

                    final studentToUpdate = studentDoc?.firstWhere(
                        (student) => student['iD'] == studentModel.iD);
                    studentToUpdate['isEligible'] = v.toString();

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
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(studentModel.iD,
                          style: const TextStyle(color: Colors.white))),
                )
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Constants.coolOrange, size: 30.0),
            onTap: () {
              Get.toNamed(StudentDetailPage.id, arguments: studentModel);
            },
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Constants.coolBlue,
        title: Text(course.value.courseCode),
      ),
      backgroundColor: Constants.coolBlue,
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
            final courseDetails = CourseModel.fromJson(data);
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
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
