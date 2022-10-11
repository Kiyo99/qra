import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/course/course_model.dart';
import 'package:qra/data/fb_student_model/student_model.dart';
import 'package:qra/presentation/course_delegate.dart';
import 'package:qra/presentation/search_button.dart';

class SubscribeToCourseScreen extends HookWidget {
  static const id = "/subscribe_to_course_screen";

  SubscribeToCourseScreen({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _courseStream =
      FirebaseFirestore.instance.collection("Courses").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.coolBlue,
        appBar: AppBar(
          title: const Text("Subscribe to a course"),
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
            return ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot documentSnapshot) {
                    Map<String, dynamic> data =
                        documentSnapshot.data()! as Map<String, dynamic>;
                    final course = CourseModel.fromJson(data);
                    // return GestureDetector(
                    //   onTap: () {
                    //     // Get.to(const MakeBody());
                    //     print("The index that was tapped is: ${data}");
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 10),
                    //     child: Container(
                    //       margin: const EdgeInsets.only(bottom: 10),
                    //       decoration: BoxDecoration(
                    //         color: const Color.fromRGBO(64, 75, 96, .9),
                    //         borderRadius: BorderRadius.circular(30.0),
                    //       ),
                    //       padding: const EdgeInsets.all(20),
                    //       child: Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Row(
                    //             mainAxisAlignment:
                    //             MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text(
                    //                 data["Course Name"],
                    //                 style: const TextStyle(
                    //                     color: Colors.white,
                    //                     fontWeight: FontWeight.bold,
                    //                     fontSize: 18),
                    //               ),
                    //               IconButton(
                    //                   onPressed: () {},
                    //                   icon: const Icon(
                    //                     Icons.more_vert_outlined,
                    //                     color: Colors.white,
                    //                   ))
                    //             ],
                    //           ),
                    //           const SizedBox(height: 10),
                    //           Text(
                    //             data["Course Code"],
                    //             style: const TextStyle(
                    //                 color: Colors.white, fontSize: 14),
                    //           ),
                    //           const SizedBox(height: 20),
                    //           Text(
                    //             data["Teacher"] ?? "",
                    //             style: const TextStyle(
                    //                 color: Colors.grey, fontSize: 14),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // );

                    return ListTile(
                      title: Text(course.courseName),
                      subtitle: Text(course.courseCode),
                      onTap: () async {
                        // print("Entry: ${auth.currentUser}");
                        final studentsDoc = await _fireStore
                            .collection("Users")
                            .doc(auth.currentUser!.email.toString())
                            .get();
                        final student =
                            StudentModel.fromJson(studentsDoc.data()!);
                        print("Entry: ${student.isEligible}");

                        await _fireStore
                            .collection("Courses")
                            .doc(course.courseCode)
                            .update({
                          "students": FieldValue.arrayUnion([
                            studentsDoc.data()!,
                          ])
                        });

                        // await _fireStore
                        //     .collection('Courses')
                        //     .doc(course.courseCode)
                        //     .set({
                        //   'Students': [
                        //     {
                        //       "Student": studentsDoc.data()!,
                        //     }
                        //   ]
                        // }, SetOptions(merge: true)).then((value) {
                        //   //Do your stuff.
                        // });
                      },
                    );
                  })
                  .toList()
                  .cast(),
            );
          },
        ));
  }
}
