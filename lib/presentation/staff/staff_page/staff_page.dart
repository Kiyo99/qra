import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:qra/constants.dart';
import 'package:qra/presentation/auth/login_page.dart';
import 'package:qra/presentation/staff/staff_search_delegate/staff_delegate.dart';
import 'package:qra/presentation/widgets/search_button.dart';
import 'package:qra/presentation/staff/courses/view_courses.dart';
import 'package:qra/presentation/staff/scanner/scanner_improved.dart';
import 'package:qra/presentation/staff/courses/upload_course.dart';

class StaffPage extends HookWidget {
  static const id = 'staff_page';

  const StaffPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedIndex = useState(0);
    PageController pageController = PageController();

    final ultimateBottom = BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.blur_on), label: "QR"),
        BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined), label: "Upload course"),
      ],
      backgroundColor: Constants.coolBlue,
      currentIndex: _selectedIndex.value,
      selectedItemColor: Constants.coolOrange,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: false,
      onTap: (index) {
        _selectedIndex.value = index;
        // pageController.animateToPage(_selectedIndex.value, duration: const Duration(milliseconds: 1000), curve: Curves.bounceOut);
        pageController.jumpToPage(_selectedIndex.value);
      },
    );

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Constants.coolBlue,
      title: const Text("Qra"),
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
            final auth = FirebaseAuth.instance;
            //
            await auth.signOut();
            //todo: find a way to take the user back to the login page after this is done
            // print(auth.currentUser);
            Get.offAndToNamed(LoginPage.id);
            // navigate(context);
          },
        )
      ],
    );

    final ultimateBody = PageView(
      controller: pageController,
      onPageChanged: (value) {
        _selectedIndex.value = value;
      },
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ViewCoursesScreen(),
        const ImprovedScanner(),
        UploadCourseScreen(),
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xff3A4256),
      appBar: topAppBar,
      body: ultimateBody,
      bottomNavigationBar: ultimateBottom,
    );
  }
}
