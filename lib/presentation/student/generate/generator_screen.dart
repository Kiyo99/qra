import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:qra/presentation/student/generate/viewQr.dart';
import 'package:qra/presentation/widgets/app_dialogs.dart';
import 'package:qra/presentation/widgets/primary_app_button.dart';
import 'package:qra/presentation/widgets/prompts.dart';

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
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  children: [
                    Transform.scale(
                      scale: 0.60,
                      child: Lottie.asset(
                        "assets/lottie/scanning.json",
                        frameRate: FrameRate(50),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text("Let's generate your QR information",
                          style: GoogleFonts.exo2(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 50),
                    PrimaryAppButton(title: "Generate QR Code", onPressed: () async {
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
