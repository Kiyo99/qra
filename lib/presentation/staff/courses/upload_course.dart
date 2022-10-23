import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qra/constants.dart';
import 'package:intl/intl.dart';
import 'package:qra/presentation/widgets/app_dialogs.dart';
import 'package:qra/presentation/widgets/app_modal.dart';
import 'package:qra/presentation/widgets/app_text_field.dart';
import 'package:qra/presentation/widgets/primary_app_button.dart';
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


    DateTime currentDate = DateTime.now();
    DateTime expiry = DateTime.parse("2022-10-24");
    print("Expiry is: ${expiry}");


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
                      AppTextField(
                          controller: courseName, title: "Course Name"),
                      AppTextField(
                          controller: courseCode, title: "Course Code"),
                      AppTextField(controller: teacher, title: "Teacher"),
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
                      const SizedBox(height: 30),
                      PrimaryAppButton(
                        title: "Upload Course",
                        onPressed: () async {
                          if (courseCode.text.isEmpty ||
                              courseName.text.isEmpty ||
                              teacher.text.isEmpty ||
                              dueDate.text.isEmpty) {
                            AppModal.showToast(
                                context, 'Please enter all fields');
                            return;
                          }

                          AppModal.showModal(
                              context: context,
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
                                  Get.back();

                                  AppModal.showModal(
                                    context: context,
                                    title: 'Success',
                                    message:
                                        'You have successfully uploaded ${courseCode.text}.',
                                    asset: 'assets/lottie/success.json',
                                    primaryAction: () {
                                      Get.back();
                                    },
                                    buttonText: 'Okay',
                                  );

                                  courseName.clear();
                                  courseCode.clear();
                                  dueDate.clear();
                                  teacher.clear();
                                }).onError((error, stackTrace) => () {
                                          Get.back();
                                          AppModal.showModal(
                                            context: context,
                                            title: 'Error',
                                            message:
                                                'Failed to upload ${courseCode.text}.',
                                            asset: 'assets/lottie/error.json',
                                            primaryAction: () {
                                              Get.back();
                                            },
                                            buttonText: 'Okay',
                                          );
                                        });
                              },
                              buttonText: "Yes, upload",
                              showSecondary: true);
                        },
                      )
                    ],
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()));
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
