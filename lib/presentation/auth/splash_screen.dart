import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:qra/data/datasource/auth_local_datasource.dart';
import 'package:qra/presentation/auth/intro_screen.dart';

class SplashScreen extends HookConsumerWidget {
  static const id = "/sp";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    dynamic user = ref.read(AuthLocalDataSource.provider).getCachedUser();

    Future.delayed(const Duration(seconds: 5), () {
      print("Moving");
      Get.toNamed(IntroScreen.id);

      //TODO: All destination checks would happen here.
      //TODO: 1. New user = intro screen
      //TODO: 2. Old user = new check for destination whether student or staff
      //TODO: 3. App installed = Old user but not logged in? = Login page

      // user['id'] == null
      //     ? Get.offNamedUntil(AuthScreen.id, (route) => false)
      //     : Get.offNamedUntil(MyHomePage.id, (route) => false);
    });
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/qra_logo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Transform.scale(
            scale: 1,
            child: Lottie.asset(
              "assets/lottie/intro_qr.json",
              animate: true,
            ),
          ),
        ),
      ),
    );
  }
}
