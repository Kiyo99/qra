import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:qra/constants.dart';
import 'package:qra/presentation/staff/scanner/scanner.dart';
import 'package:qra/presentation/widgets/app_modal.dart';
import 'package:qra/presentation/widgets/primary_app_button.dart';

class ImprovedScanner extends HookConsumerWidget {
  static const id = "/generate";

  const ImprovedScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _fireStore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;

    final items = useState(['Course code...']);
    final selectedValue = useState(items.value[0]);

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Transform.scale(
                        scale: 0.60,
                        child: Lottie.asset(
                          "assets/lottie/scanning.json",
                          frameRate: FrameRate(60),
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text("Let's Scan these students",
                          style: GoogleFonts.exo2(
                              fontSize: 20,
                              color: Constants.coolGrey,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: StreamBuilder(
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

                          for (int i = 0; i < userDocument.length; i++) {
                            items.value.addIf(
                                !(items.value.contains(userDocument[i].id)),
                                userDocument[i].id);
                          }

                          return Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Color(0xffbfbfbf),
                                borderRadius: BorderRadius.circular(15.0)),
                            child: DropdownButtonFormField(
                              items: items.value
                                  .map<DropdownMenuItem<String>>(
                                      (String value) => DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          ))
                                  .toList(),
                              value: selectedValue.value,
                              focusColor: Colors.white.withOpacity(0.8),
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
                    ),
                    const SizedBox(height: 20),
                    PrimaryAppButton(
                        title: "Scan",
                        onPressed: () {
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
                        }),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
