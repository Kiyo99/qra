import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/presentation/auth/login_page.dart';
import 'package:qra/presentation/staff/courses/view_courses.dart';
import 'package:qra/presentation/student/courses/subscribe_to_course.dart';

class StudentOptionsScreen extends HookConsumerWidget {
  const StudentOptionsScreen({Key? key, required this.title}) : super(key: key);

  // static final appOrderViewModel = AppOrderViewModel.provider;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // dynamic data = ref.watch(AppOrderViewModel.provider).currentTrip;

    var items = [
      'Update student information',
      'About',
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
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                    if (items[index] == 'Update student information') {
                      print("We finna update");
                      Get.toNamed(SubscribeToCourseScreen.id);
                      return;
                    }
                    if (items[index] == 'About') {
                      Get.toNamed(ViewCoursesScreen.id);
                      print("We finna About");
                      return;
                    }
                    if (items[index] == 'Log out') {
                      print("We finna log out");
                      final auth = FirebaseAuth.instance;
                      //
                      await auth.signOut();

                      // print(auth.currentUser);
                      Get.offAndToNamed(LoginPage.id);
                      // navigate(context);
                      return;
                    } else {
                      return;
                    }
                    // ref.read(AppOrderViewModel.provider).reportOrder(items[index], data['id'].toString());
                  },
                  title: Text(
                    items[index],
                    style: const TextStyle(fontSize: 14),
                  ),
                  leading: items[index] == 'Update student information'
                      ? const Icon(Icons.light_mode_outlined)
                      : items[index] == 'Log out'
                          ? const Icon(Icons.logout_outlined)
                          : items[index] == 'About'
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
