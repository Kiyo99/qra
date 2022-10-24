import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/constants.dart';
import 'package:qra/presentation/staff/scanner/scanner.dart';
import 'package:qra/presentation/widgets/app_modal.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class ImprovedScanner extends HookConsumerWidget {
  static const id = "/generate";

  const ImprovedScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _fireStore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;

    final items = useState(['Course code...']);
    final selectedValue = useState(items.value[0]);

    return Scaffold(
      body: Stack(children: [
        Center(
          child: Row(
            children: [
              Container(
                color: Colors.white,
                height: 200,
                width: MediaQuery.of(context).size.width / 2,
              ),
              Container(
                color: Constants.coolBlue,
                height: 200,
                width: MediaQuery.of(context).size.width / 2,
              )
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 43),
              height: MediaQuery.of(context).size.height / 2.7,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(70)),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 90, 20, 10),
                  child: Text(
                    "Ready for exams?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.exo2(
                        fontSize: 30, color: Constants.coolBlue),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  color: Constants.coolBlue,
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(70)),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text("Let's Scan these students",
                            style: GoogleFonts.exo2(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 50),
                      StreamBuilder(
                        stream: _fireStore
                            .collection("Courses")
                            .orderBy("courseCode")
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Text("Loading");
                          }
                          final userDocument = snapshot.data!.docs;
                          print("Doc: ${userDocument}");

                          for (int i = 0; i < userDocument.length; i++) {
                            items.value.addIf(
                                !(items.value.contains(userDocument[i].id)),
                                userDocument[i].id);
                          }

                          return Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: DropdownButtonFormField(
                              items: items.value
                                  .map<DropdownMenuItem<String>>(
                                      (String value) =>
                                          DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          ))
                                  .toList(),
                              value: selectedValue.value,
                              hint: Text("Choose a course..."),
                              focusColor: Colors.white,
                              iconEnabledColor: Constants.coolOrange,
                              // decoration: InputDecoration(
                              //   filled: true,
                              //   hintStyle: TextStyle(color: Colors.grey[800]),
                              //   hintText: "Name",
                              //   // fillColor: Colors.blue[200],
                              // ),
                              style: const TextStyle(color: Colors.black),
                              dropdownColor: Colors.grey,
                              onChanged: (val) {
                                selectedValue.value = val.toString();
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      ConfirmationSlider(
                        stickToEnd: false,
                        text: "Slide to scan",
                        textStyle: GoogleFonts.exo2(
                            color: Constants.coolBlue,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                        onConfirmation: () {
                          if (selectedValue.value == "Course code...") {
                            AppModal.showModal(
                              context: context,
                              title: "Error",
                              message: "Please select a course code to proceed",
                              asset: "assets/lottie/error.json",
                              primaryAction: () {
                                Get.back();
                              },
                              buttonText: "Okay",
                            );
                            return;
                          }

                          Get.to(QrScanner(), arguments: selectedValue.value);
                        },
                        height: 50,
                        foregroundColor: Constants.blueish,
                        backgroundColor: Constants.coolOrange,
                        backgroundColorEnd: Constants.coolOrange,
                        shadow: const BoxShadow(color: Colors.transparent),
                        backgroundShape: BorderRadius.circular(15.0),
                        sliderButtonContent: const Icon(Icons.chevron_right,
                            color: Colors.white, size: 30),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
