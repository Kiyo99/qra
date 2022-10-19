import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/constants.dart';
import 'package:qra/presentation/student/generate/viewQr.dart';
import 'package:qra/presentation/widgets/app_dialogs.dart';
import 'package:qra/presentation/widgets/prompts.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class ImprovedQrGenerator extends HookConsumerWidget {
  static const id = "/generate";

  const ImprovedQrGenerator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _fireStore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
    dynamic data;
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
                  padding: EdgeInsets.fromLTRB(0, 90, 0, 10),
                  child: Text(
                    "Ready for exams?",
                    style: GoogleFonts.exo2(
                        fontSize: 40, color: Constants.coolBlue),
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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text("Let's generate your QR information",
                            style: GoogleFonts.exo2(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      // const SizedBox(height: 50),
                      // ConfirmationSlider(
                      //   stickToEnd: false,
                      //   text: "Slide to scan",
                      //   textStyle: TextStyle(
                      //       color: Constants.coolBlue,
                      //       fontWeight: FontWeight.w700,
                      //       fontSize: 15),
                      //   onConfirmation: () {
                      //     Get.to(const QrScanner());
                      //     // ref.read(AppOrderViewModel.provider).generateOTP(
                      //     //     currentOrder['id'].toString(), 'true', 'Pick up');
                      //     // ref.read(AppOrderViewModel.Provider).getTripStage('PICKUP_CONFIRMED');
                      //     // ref.read(MapsViewModel.provider).updateMap('PICKUP_CONFIRMED');
                      //   },
                      //   height: 50,
                      //   foregroundColor: Colors.green,
                      //   backgroundColor: Colors.greenAccent,
                      //   backgroundColorEnd: Colors.blueGrey,
                      //   shadow: const BoxShadow(color: Colors.transparent),
                      //   backgroundShape: BorderRadius.circular(15.0),
                      //   sliderButtonContent: const Icon(Icons.chevron_right,
                      //       color: Colors.white, size: 30),
                      // ),
                      const SizedBox(height: 50),
                      ConfirmationSlider(
                        stickToEnd: false,
                        text: "Slide to generate code",
                        textStyle: GoogleFonts.exo2(
                            color: Constants.coolBlue,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                        onConfirmation: () async {
                          AppDialogs.lottieLoader();
                          _fireStore
                              .collection("Users")
                              .doc(currentUser!.email)
                              .get()
                              .then((doc) {
                            if (doc.exists) {
                              Get.back();
                              data = doc.data();
                              Get.to(ViewQr(), arguments: data);
                            } else {
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
                                  asset: 'assets/lottie/error.json',
                                  primaryAction: () {
                                    Get.back();
                                  },
                                  message: 'Failed to fetch details',
                                  title: 'Error',
                                  showSecondary: false,
                                  buttonText: 'Okay',
                                ),
                              );
                            }
                          });
                        },
                        height: 50,
                        foregroundColor: Colors.green,
                        backgroundColor: Colors.greenAccent,
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
