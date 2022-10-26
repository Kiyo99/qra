import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/datasource/auth_local_datasource.dart';
import 'package:qra/presentation/auth/components/intro_pager_item.dart';
import 'package:qra/presentation/auth/login_page.dart';
import 'package:qra/presentation/staff/staff_page/staff_page.dart';
import 'package:qra/presentation/student/student_page/student_page.dart';
import 'package:qra/presentation/widgets/primary_app_button.dart';
import 'package:qra/presentation/widgets/secondary_app_button.dart';
import 'package:qra/presentation/widgets/slider_indicator.dart';

class IntroScreen extends HookConsumerWidget {
  static const id = "/intro";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSlide = useState(0);
    final pageController = usePageController();
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    return Scaffold(
      backgroundColor: Constants.coolBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: PageView(
                controller: pageController,
                onPageChanged: (idx) => currentSlide.value = idx,
                children: IntroPagerModel.slides
                    .map((e) => IntroPagerItem(slide: e))
                    .toList(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: SliderIndicator(
                    slideCount: IntroPagerModel.slides.length,
                    currentSlide: currentSlide.value,
                  ),
                ),
                PrimaryAppButton(
                  title: currentSlide.value < 3 ? "Next" : "Done",
                  onPressed: () {
                    if (currentSlide.value < 3) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    } else {
                      ref.read(AuthLocalDataSource.provider).setViewedIntro();
                      user == null
                          ? Get.offAllNamed(LoginPage.id)
                          : Get.offAllNamed(StudentPage.id);
                    }
                  },
                ),
                const SizedBox(height: 10),
                AnimatedContainer(
                  curve: Curves.linear,
                  margin: const EdgeInsets.only(bottom: 30),
                  duration: const Duration(milliseconds: 300),
                  child: Visibility(
                    replacement: const SizedBox(
                      height: 30,
                    ),
                    visible: currentSlide.value < 3,
                    child: SecondaryAppButton(
                      title: "Skip",
                      onPressed: () {
                        ref.read(AuthLocalDataSource.provider).setViewedIntro();
                        user == null
                            ? Get.offAllNamed(LoginPage.id)
                            : Get.offAllNamed(StaffPage.id);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
