import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/presentation/auth/intro_screen.dart';
import 'package:qra/presentation/auth/login_page.dart';
import 'package:qra/presentation/auth/register_page.dart';
import 'package:qra/presentation/student/student_details.dart';
import 'package:qra/presentation/staff/courses/view_courses.dart';
import 'package:qra/presentation/staff/scanner/scanner.dart';
import 'package:qra/presentation/staff/staff_page/staff_page.dart';
import 'package:qra/presentation/student/courses/subscribe_to_course.dart';
import 'package:qra/presentation/staff/courses/upload_course.dart';
import 'package:qra/presentation/student/generate/viewQr.dart';
import 'package:qra/presentation/student/student_page/student_page.dart';
import 'package:qra/presentation/staff/courses/view_course_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  await Firebase.initializeApp();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: DevicePreview(
        enabled: false,
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          theme: ThemeData.dark(),
          // darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system,
          title: 'QRA',
          debugShowCheckedModeBanner: false,
          routes: {
            QrScanner.id: (context) => const QrScanner(),
            LoginPage.id: (context) => LoginPage(),
            StaffPage.id: (context) => const StaffPage(),
            StudentPage.id: (context) => StudentPage(),
            UploadCourseScreen.id: (context) => UploadCourseScreen(),
            ViewCoursesScreen.id: (context) => ViewCoursesScreen(),
            ViewCourseDetails.id: (context) => ViewCourseDetails(),
            StudentDetailPage.id: (context) => const StudentDetailPage(),
            SubscribeToCourseScreen.id: (context) => SubscribeToCourseScreen(),
            RegisterPage.id: (context) => RegisterPage(),
            ViewQr.id: (context) => ViewQr(),
          },
          home: IntroScreen()),
    );
  }
}

//todo: lecturer is greeted with a list of available courses for that day (filter by date?, Use current date as query???,

//todo: create a screen for deleting courses, (Only lecturers or admins or exam controller)

//todo: How you will automatically check the box is this. There wil be a stream that listens to this shit.
//todo It will update the user data based on the ID. Then the attendance sheet will know that something has changed and rebuild itself
//todo (You could use a stream-builder again for the attendance sheet just like you are for the courses)

//todo live chat with vvu its
// todo: From tomorrow: Find a way for student to get list of subscribed courses {Use course codes}
// todo: Should I dedicated courses field for students? Yes, that means I will update the student model with build runner

// todo create walkthrough

//todo: Add subscribed courses to menu and then fetch the list. Add courses to students model
//todo: Look at either locally caching the person or having useState
//todo: Check out checkbox issue

//todo: Think about the attendance marking flow.

//todo: Make the showToast a widget

//todo: Remember functionality of due date all round with filtering

//todo: Change the value of isEligible to bool, why me???
//todo: try to set light and dark theme
//todo: try to make the attendance list a stream builder also
//todo: refactor code to change all colors at once
//todo: refactor code to have one text theme, google fonts
//todo: or have like 2 or 3 global text themes in constants and call them from there

//todo: refactor lottie for view normal courses maybe to no internet

//todo: Refactor showBottomSheet to be a method

//todo: Should the lecturer be able to download pdf of the attendance sheet?

//todo: Sort the attendance sheet by alphabetical order. Include a search feature
//todo: Handle errors on view course details
