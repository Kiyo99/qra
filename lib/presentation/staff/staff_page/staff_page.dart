import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:qra/presentation/auth/login_page.dart';
import 'package:qra/presentation/staff/scanner/scanner_improved.dart';
import 'package:qra/presentation/student/generate/generator_improved.dart';
import 'package:qra/presentation/staff/teachers_page.dart';
import 'package:qra/presentation/student/student_page/student_page.dart';

class StaffPage extends HookWidget {
  const StaffPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final _selectedIndex = useState(0);
    PageController pageController = PageController();

    final ultimateBottom = BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.blur_on), label: "QR"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_box), label: "Profile"),
      ],
      backgroundColor: const Color(0xff3A4256),
      currentIndex: _selectedIndex.value,
      selectedItemColor: Colors.white,
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
      backgroundColor: const Color(0xff3A4256),
      title: const Text("Qra"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Get.to(const StudentPage(title: "Student page"));
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
        const TeachersPage(),
        const ImprovedScanner(),
        Container(),
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
