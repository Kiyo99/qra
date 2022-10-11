import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/course/course_model.dart';
import 'package:qra/presentation/course_delegate.dart';
import 'package:qra/presentation/search_button.dart';

class ViewCoursesScreen extends HookWidget {
  static const id = "/view_course_screen";

  ViewCoursesScreen({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _courseStream =
      FirebaseFirestore.instance.collection("Courses").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.coolBlue,
        appBar: AppBar(
          title: const Text("View courses"),
          backgroundColor: Constants.coolBlue,
          actions: [
            SearchButton(
              onPressed: () async {
                final searchResult = await showSearch(
                  context: context,
                  delegate: CourseDelegate(),
                );

                // if (searchResult != null) {
                //   final typedProduct = Product.fromJson(
                //     searchResult,
                //   );
                //   createPostViewModel.setProduct(
                //     typedProduct,
                //   );
                // }
              },
            ),
          ],
          elevation: 0,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _courseStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.data?.size == 0) {
              return const Center(
                child: Text(
                  "No courses yet. Check in later",
                  style: TextStyle(fontSize: 20),
                ),
              );
            }

            return Container(
              margin: const EdgeInsets.only(top: 20),
              child: ListView(
                children: snapshot.data!.docs
                    .map((DocumentSnapshot documentSnapshot) {
                  Map<String, dynamic> data =
                      documentSnapshot.data()! as Map<String, dynamic>;
                  final course = CourseModel.fromJson(data);
                  return GestureDetector(
                    onTap: () {
                      // Get.to(const MakeBody());
                      print("The index that was tapped is: ${data}");
                      print(course.students);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(64, 75, 96, .9),
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
                                Text(
                                  course.courseName,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.more_vert_outlined,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              course.courseCode,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              course.teacher,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                  // return ListTile(
                  //   title: Text(data['Course Name']),
                  //   subtitle: Text(data["Course Code"]),
                  //   onTap: () {
                  //     print("Entry: ${data['Course Name']}");
                  //   },
                  // );
                }).toList(),
              ),
            );
          },
        ));
  }
}