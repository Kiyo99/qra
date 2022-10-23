import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/course/course_model.dart';
import 'package:qra/presentation/staff/courses/view_course_details.dart';

class BuildCourseCard extends HookWidget {
  const BuildCourseCard({Key? key, required this.courses}) : super(key: key);

  final List<CourseModel> courses;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return Dismissible(
              //todo: Implement deleting a course here
              key: UniqueKey(),
              background: Container(color: Colors.red),
              onDismissed: (d) {
                print("Dismissed");
              },
              child: GestureDetector(
                onTap: () {
                  // Get.to(const MakeBody());
                  // print("The index that was tapped is: ${course}");
                  // print(course.students);

                  Get.toNamed(ViewCourseDetails.id, arguments: courses[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Constants.secondaryBlue,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                courses[index].courseName,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.chevron_right_outlined,
                                  color: Constants.coolOrange,
                                ))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          courses[index].courseCode,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          courses[index].teacher,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
