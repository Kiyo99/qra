import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/data/datasource/auth_local_datasource.dart';
import 'package:qra/presentation/auth/login_page.dart';
import 'package:qra/presentation/staff/staff_search_delegate/staff_delegate.dart';
import 'package:qra/presentation/widgets/app_modal.dart';
import 'package:qra/presentation/widgets/search_button.dart';
import 'package:qra/presentation/staff/courses/view_courses.dart';
import 'package:qra/presentation/staff/scanner/scanner_screen.dart';
import 'package:qra/presentation/staff/courses/upload_course.dart';

class StaffPage extends HookConsumerWidget {
  static const id = 'staff_page';

  const StaffPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _selectedIndex = useState(0);
    PageController pageController = PageController();

    final ultimateBottom = BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.blur_on), label: "QR"),
        BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined), label: "Upload course"),
      ],
      currentIndex: _selectedIndex.value,
      showUnselectedLabels: false,
      onTap: (index) {
        _selectedIndex.value = index;
        // pageController.animateToPage(_selectedIndex.value, duration: const Duration(milliseconds: 1000), curve: Curves.bounceOut);
        pageController.jumpToPage(_selectedIndex.value);
      },
    );

    final topAppBar = AppBar(
      elevation: 0.0,
      title: Text("Qra", style: GoogleFonts.exo2(fontWeight: FontWeight.bold)),
      actions: <Widget>[
        if (_selectedIndex.value == 0)
          SearchButton(
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: StaffDelegate(),
              );
            },
          ),
        IconButton(
          icon: const Icon(Icons.logout_outlined),
          onPressed: () async {
            AppModal.showModal(
                context: context,
                title: "Log out?",
                message: "Are you sure you want to log out?",
                asset: "assets/lottie/warning.json",
                primaryAction: () async {
                  final auth = FirebaseAuth.instance;
                  //
                  await auth.signOut();
                  ref.read(AuthLocalDataSource.provider).clearUserData();

                  // print(auth.currentUser);
                  Get.offAndToNamed(LoginPage.id);
                },
                buttonText: "Yes, log out",
                showSecondary: true);
          },
        )
      ],
    );

    final ultimateBody = PageView(
      controller: pageController,
      onPageChanged: (value) {
        _selectedIndex.value = value;
      },
      children: [
        const ViewCoursesScreen(),
        const ImprovedScanner(),
        UploadCourseScreen(),
      ],
    );

    return Scaffold(
      appBar: topAppBar,
      body: ultimateBody,
      bottomNavigationBar: ultimateBottom,
    );
  }
}
