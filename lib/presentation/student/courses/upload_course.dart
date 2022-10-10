import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qra/constants.dart';

class UploadCourseScreen extends HookWidget {
  static const id = "/upload_course_screen";

  UploadCourseScreen({Key? key}) : super(key: key);
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final TextEditingController courseName = TextEditingController();
    final TextEditingController courseCode = TextEditingController();
    final TextEditingController teacher = TextEditingController();
    final isLoading = useState(false);

    return Scaffold(
        backgroundColor: Constants.coolBlue,
        body: isLoading.value == false
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: ListView(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: courseName,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: const OutlineInputBorder(),
                              labelText: 'Course Name',
                              labelStyle:
                                  GoogleFonts.exo2(color: Colors.white)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: courseCode,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: const OutlineInputBorder(),
                              labelText: 'Course Code',
                              labelStyle:
                                  GoogleFonts.exo2(color: Colors.white)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: teacher,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: const OutlineInputBorder(),
                              labelText: 'Teacher',
                              labelStyle:
                                  GoogleFonts.exo2(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                            child: const Text('Upload Course'),
                            onPressed: () async {
                              isLoading.value = true;

                              Map<String, Object> db = {};
                              db['courseName'] = courseName.text;
                              db['courseCode'] = courseCode.text;
                              db['teacher'] = teacher.text;

                              _firestore
                                  .collection("Courses")
                                  .doc(db['courseCode'].toString())
                                  .set(db)
                                  .whenComplete(() {
                                isLoading.value = false;
                                _showToast(
                                    context, 'Successfully uploaded course');
                              }).onError((error, stackTrace) => () {
                                        isLoading.value = false;
                                        _showToast(context, 'Failed to save');
                                        print('Faileddddddddd: $error');
                                      });
                              // Get.to(const StaffPage(title: "QRA"));
                            }),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()));
  }
}

void _showToast(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      action: SnackBarAction(
          label: 'Got it', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
