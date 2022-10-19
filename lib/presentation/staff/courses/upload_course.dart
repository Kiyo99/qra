import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qra/constants.dart';
import 'package:intl/intl.dart';
import 'package:qra/presentation/widgets/app_dialogs.dart';
import 'package:qra/presentation/widgets/prompts.dart';

class UploadCourseScreen extends HookWidget {
  static const id = "/upload_course_screen";

  UploadCourseScreen({Key? key}) : super(key: key);
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final TextEditingController courseName = TextEditingController();
    final TextEditingController courseCode = TextEditingController();
    final TextEditingController dueDate = TextEditingController();
    final TextEditingController teacher = TextEditingController();
    final isLoading = useState(false);

    _selectDate(BuildContext context) async {
      await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2022, 1),
          lastDate: DateTime(2050, 12),
          builder: (context, picker) {
            return Theme(
              //TODO: change colors
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  surface: Colors.blueGrey,
                  onSurface: Colors.yellow,
                ),
                dialogBackgroundColor: Constants.coolBlue,
              ),
              child: picker!,
            );
          }).then((selectedDate) {
        //TODO: handle selected date
        if (selectedDate != null) {
          dueDate.text = DateFormat('yyyy-MM-dd').format(selectedDate);
          print("New date: ${dueDate.text}");
        }
      });
    }

    return Scaffold(
        backgroundColor: Constants.coolBlue,
        body: isLoading.value == false
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: courseName,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Constants.coolOrange)),
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
                          cursorColor: Constants.coolOrange,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.coolOrange)),
                            border: const OutlineInputBorder(),
                            labelText: 'Course Code',
                            labelStyle: GoogleFonts.exo2(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: dueDate,
                          focusNode: AlwaysDisabledFocusNode(),
                          onTap: () {
                            _selectDate(context);
                          },
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: const OutlineInputBorder(),
                              labelText: 'Due date',
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
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Constants.coolOrange)),
                              labelText: 'Teacher',
                              labelStyle:
                                  GoogleFonts.exo2(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: TextButton(
                          onPressed: () async {
                            if (courseCode.text.isEmpty ||
                                courseName.text.isEmpty ||
                                teacher.text.isEmpty ||
                                dueDate.text.isEmpty) {
                              _showToast(context, 'Please enter all fields');
                              return;
                            }

                            showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25.0),
                                        topRight: Radius.circular(25.0))),
                                builder: (ctx) => AppPrompts(
                                    title: "Upload?",
                                    message:
                                        "Are you sure you want to upload ${courseName.text}?",
                                    asset: "assets/lottie/warning.json",
                                    primaryAction: () async {
                                      Get.back();
                                      AppDialogs.lottieLoader();

                                      Map<String, Object> db = {};
                                      db['courseName'] = courseName.text;
                                      db['courseCode'] = courseCode.text;
                                      db['dueDate'] = dueDate.text;
                                      db['teacher'] = teacher.text;

                                      _firestore
                                          .collection("Courses")
                                          .doc(db['courseCode'].toString())
                                          .set(db)
                                          .whenComplete(() {
                                        courseName.clear();
                                        courseCode.clear();
                                        dueDate.clear();
                                        teacher.clear();
                                        Get.back();
                                        showModalBottomSheet(
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25.0),
                                              topRight: Radius.circular(25.0),
                                            ),
                                          ),
                                          isScrollControlled: true,
                                          builder: (ctx) => AppPrompts(
                                            asset: 'assets/lottie/success.json',
                                            primaryAction: () {
                                              Get.back();
                                            },
                                            message:
                                                'You have successfully uploaded ${courseCode.text}.',
                                            title: 'Success',
                                            showSecondary: false,
                                            buttonText: 'Okay',
                                          ),
                                        );
                                      }).onError((error, stackTrace) => () {
                                                Get.back();
                                                _showToast(context,
                                                    'Failed to upload ${courseCode.text}');
                                                print('Faileddddddddd: $error');
                                              });
                                    },
                                    buttonText: "Yes, upload",
                                    showSecondary: true));
                          },
                          child: Text('Upload Course',
                              style: GoogleFonts.exo2(
                                  color: Constants.coolBlue,
                                  fontWeight: FontWeight.w600)),
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: Constants.coolOrange,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              backgroundColor: Constants.coolOrange),
                        ),
                      )
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
