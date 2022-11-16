import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/datasource/auth_local_datasource.dart';
import 'package:qra/data/student_model/student_model.dart';
import 'package:qra/presentation/auth/login_page.dart';
import 'package:qra/presentation/student/courses/subscribed_courses.dart';
import 'package:qra/presentation/widgets/app_dialogs.dart';
import 'package:qra/presentation/widgets/app_modal.dart';
import 'package:qra/presentation/widgets/prompts.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentOptionsScreen extends HookConsumerWidget {
  StudentOptionsScreen({Key? key, required this.title}) : super(key: key);

  // static final appOrderViewModel = AppOrderViewModel.provider;
  final String title;
  final auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var items = [
      'Update student information',
      'Subscribed courses',
      'Live chat',
      'About Qra',
      'Log out',
    ];
    return Container(
      padding: const EdgeInsets.all(8.0),
      // height: MediaQuery.of(context).size.height - 100,
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Text(
              title,
              style:
                  GoogleFonts.exo2(fontSize: 20, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () async {
                    if (items[index] == 'Log out') {
                      AppModal.showModal(
                          context: context,
                          title: "Log out?",
                          message: "Are you sure you want to log out?",
                          asset: "assets/lottie/warning.json",
                          primaryAction: () async {
                            final auth = FirebaseAuth.instance;
                            //
                            await auth.signOut();
                            ref
                                .read(AuthLocalDataSource.provider)
                                .clearUserData();

                            // print(auth.currentUser);
                            Get.offAndToNamed(LoginPage.id);
                          },
                          buttonText: "Yes, log out",
                          showSecondary: true);

                      // navigate(context);
                      return;
                    }

                    if (items[index] == 'Subscribed courses') {
                      AppDialogs.lottieLoader();
                     await _fireStore
                          .collection("Users")
                          .doc(auth.currentUser!.email)
                          .get()
                          .then((doc) {
                        if (doc.exists) {
                          Get.back();
                          final student = StudentModel.fromJson(doc.data()!);
                          print("fcgbjn: ${student}");

                          Get.toNamed(SubscribedCoursesScreen.id, arguments: student);
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
                      return;
                    }

                    if (items[index] == 'Live chat') {
                      var url = "https://wa.me/${Constants.WHATSAPP}";
                      await launch(url);
                      return;
                    } else {
                      return;
                    }
                    // ref.read(AppOrderViewModel.provider).reportOrder(items[index], data['id'].toString());
                  },
                  title: Text(
                    items[index],
                    style: GoogleFonts.exo2(fontSize: 14),
                  ),
                  leading: items[index] == 'Update student information'
                      ? const Icon(Icons.account_circle_outlined)
                      : items[index] == 'Log out'
                          ? const Icon(Icons.logout_outlined)
                          : items[index] == 'Live chat'
                              ? const Icon(Icons.chat_bubble_outline_outlined)
                              : items[index] == 'Subscribed courses'
                                  ? const Icon(Icons.menu_book_outlined)
                                  : items[index] == 'About Qra'
                                      ? const Icon(Icons.info_outline)
                                      : const Icon(Icons.title),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
