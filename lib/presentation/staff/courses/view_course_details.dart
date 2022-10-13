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

  const ViewCourseDetails({Key? key}) : super(key: key);

  //todo: You will have to accept arguments here

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final course = useState<CourseModel>(Get.arguments);

    Card makeCard(StudentModel studentModel) => Card(
          elevation: 4.0,
          color: Constants.coolBlue,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(64, 75, 96, .9),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              leading: Container(
                  padding: const EdgeInsets.only(right: 5.0),
                  decoration: const BoxDecoration(
                      border: Border(
                          right:
                              BorderSide(width: 1.0, color: Colors.white24))),
                  child: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    value: false,
                    onChanged: (v) {
                      print("Lesson is: ${studentModel.fullName}");
                      // checkItem.value = v;
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
              trailing: const Icon(Icons.keyboard_arrow_right,
                  color: Colors.white, size: 30.0),
              onTap: () {
                Get.toNamed(StudentDetailPage.id, arguments: studentModel);
              },
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: const Color(0xff3A4256),
        title: const Text("Qra"),
      ),
      backgroundColor: Constants.coolBlue,
      body: RefreshIndicator(
        onRefresh: () {
          print("Refreshed!");
          return Future.value(0);
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: course.value.students?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(
                StudentModel.fromJson(course.value.students![index]));
            // return CheckboxListTile(
            //   value: checkItem.value[index].checked,
            //   controlAffinity: ListTileControlAffinity.leading,
            //   contentPadding: EdgeInsets.zero,
            //   onChanged: (v) {
            //     // for (var element in checkItem.value) {
            //     //   element.checked = false;
            //     // }
            //     checkItem.value[index].checked = v!;
            //     // reason.value = checkItem.value[index]["title"];
            //   },
            //   title: Text(checkItem.value[index].title),
            // );
          },
        ),
      ),
    );
  }
}
