import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/attendance/attendance_page.dart';
import 'package:qra/data/lesson.dart';
import 'package:qra/presentation/generate/viewQr.dart';
import 'package:qra/presentation/scanner/scanner.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class QrGenerator extends HookConsumerWidget {
  static const id = "generate";

  const QrGenerator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _fireStore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
    dynamic data;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.pink,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_outlined),
            tooltip: 'More',
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
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
                color: const Color(0xff181D3D),
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
                  padding: EdgeInsets.fromLTRB(0, 90, 0, 10),
                  child: Text(
                    "Ready for exams?",
                    style: GoogleFonts.exo2(
                        fontSize: 40, color: const Color(0xff181D3D)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                height: MediaQuery.of(context).size.height / 2,
                decoration: const BoxDecoration(
                  color: Color(0xff181D3D),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text("Let's connect on the QR Attendance App",
                            style: GoogleFonts.exo2(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 50),
                      ConfirmationSlider(
                        stickToEnd: false,
                        text: "Slide to scan",
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                        onConfirmation: () {
                          // Get.to(const QrScanner());
                          Get.to(const AttendancePage(title: "COSC233"));
                          // ref.read(AppOrderViewModel.provider).generateOTP(
                          //     currentOrder['id'].toString(), 'true', 'Pick up');
                          // ref.read(AppOrderViewModel.Provider).getTripStage('PICKUP_CONFIRMED');
                          // ref.read(MapsViewModel.provider).updateMap('PICKUP_CONFIRMED');
                        },
                        height: 50,
                        foregroundColor: Colors.pink,
                        backgroundColor: Colors.pinkAccent,
                        backgroundColorEnd: Colors.pink,
                        shadow: const BoxShadow(color: Colors.transparent),
                        backgroundShape: BorderRadius.circular(15.0),
                        sliderButtonContent: const Icon(Icons.chevron_right,
                            color: Colors.white, size: 30),
                      ),
                      const SizedBox(height: 30),
                      ConfirmationSlider(
                        stickToEnd: false,
                        text: "Slide to generate code",
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                        onConfirmation: () async {
                          // var document = await Firestore.instance.collection('COLLECTION_NAME').document('TESTID1');
                          // document.get() => then(function(document) {
                          // print(document("name"));
                          // });
                          print("valueeeeee");

                          _fireStore
                              .collection("Users")
                              .doc(currentUser!.email)
                              .get()
                              .then((doc) {
                            if (doc.exists) {
                              print("valueeeeee: ${doc.data()}");
                              data = doc.data();
                              print("valueeeeegge: ${data}");
                              Get.to(ViewQr(), arguments: data);
                              //todo: Move the scanning widget into a new page
                              //todo: Assign the Get argument to it when passing it. Vuala
                            } else {
                              print("Failed");
                            }
                          });
                        },
                        height: 50,
                        foregroundColor: Colors.pink,
                        backgroundColor: Colors.pinkAccent,
                        backgroundColorEnd: Colors.pink,
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

// Widget build(BuildContext context) {
//   return new StreamBuilder(
//       stream: Firestore.instance.collection('COLLECTION_NAME').document('TESTID1').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return new Text("Loading");
//         }
//         var userDocument = snapshot.data;
//         return new Text(userDocument["name"]);
//       }
//   );
// }
