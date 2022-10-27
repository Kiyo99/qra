import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
          physics: const BouncingScrollPhysics(),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(ViewCourseDetails.id, arguments: courses[index]);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.4)),
                    color: Constants.secondaryBlue,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    courses[index].courseName,
                                    style: GoogleFonts.exo2(
                                        fontSize: 18,
                                        color: Constants.coolWhite,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              courses[index].courseCode,
                              style: GoogleFonts.exo2(
                                  fontSize: 14,
                                  color: Constants.coolWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              courses[index].teacher,
                              style: GoogleFonts.exo2(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.toNamed(ViewCourseDetails.id,
                                    arguments: courses[index]);
                              },
                              icon: Icon(
                                Icons.chevron_right_outlined,
                                color: Constants.coolOrange,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
