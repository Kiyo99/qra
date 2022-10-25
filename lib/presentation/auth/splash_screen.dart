import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/datasource/auth_local_datasource.dart';
import 'package:qra/presentation/auth/intro_screen.dart';
import 'package:qra/presentation/auth/login_page.dart';
import 'package:qra/presentation/student/student_page/student_page.dart';

class SplashScreen extends HookConsumerWidget {
  static const id = "/sp";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(AuthLocalDataSource.provider).getCachedUser();
    final auth = FirebaseAuth.instance;
    print("User is ${user}");
    User? authUser = auth.currentUser;
    final viewedIntro = ref.read(AuthLocalDataSource.provider).viewedIntro();

    print("Usgger is ${viewedIntro}");

    Future.delayed(const Duration(seconds: 5), () {
      // Get.offNamed(IntroScreen.id);

      //TODO: All destination checks would happen here.
      //TODO: 1. New user = intro screen
      //TODO: 2. Old user = new check for destination whether student or staff
      //TODO: 3. App installed = Old user but not logged in? = Login page

      // if (authUser == null) {
      //   Get.offNamed(LoginPage.id);
      // }

      if (user?.status != null) {
        if (user!.status == "Student") {
          Get.offNamed(StudentPage.id);
        } else if (user.status == "Student") {
          Get.offNamed(StudentPage.id);
        } else {
          print("What the hell is going on");
        }
      } else {
        //Another check here, if the setViewedIntro is true, then log in
        if (viewedIntro == null) {
          Get.offNamed(IntroScreen.id);
        } else {
          Get.offNamed(LoginPage.id);
        }
      }

      // user['id'] == null
      //     ? Get.offNamedUntil(AuthScreen.id, (route) => false)
      //     : Get.offNamedUntil(MyHomePage.id, (route) => false);
    });
    return Scaffold(
      backgroundColor: Constants.coolOrange,
      body: Center(
        child: Transform.scale(
          scale: 1,
          child: Lottie.asset(
            "assets/lottie/intro_qr.json",
            animate: true,
          ),
        ),
      ),
    );
  }
}

//Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/qra_logo.jpg"),
//             fit: BoxFit.contain,
//           ),
//         ),
