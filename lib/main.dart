import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/constants.dart';
import 'package:qra/presentation/auth/intro_screen.dart';
import 'package:qra/presentation/auth/login_page.dart';
import 'package:qra/presentation/auth/register_page.dart';
import 'package:qra/presentation/auth/splash_screen.dart';
import 'package:qra/presentation/staff/courses/pdf_view.dart';
import 'package:qra/presentation/staff/courses/pdf_view_screen.dart';
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

import 'presentation/student/courses/subscribed_courses.dart';

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

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          theme: Constants.lightTheme,
          darkTheme: Constants.darkTheme,
          // darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system,
          title: 'QRA',
          debugShowCheckedModeBanner: false,
          routes: {
            QrScanner.id: (context) => QrScanner(),
            LoginPage.id: (context) => LoginPage(),
            IntroScreen.id: (context) => IntroScreen(),
            StaffPage.id: (context) => const StaffPage(),
            StudentPage.id: (context) => StudentPage(),
            UploadCourseScreen.id: (context) => UploadCourseScreen(),
            ViewCoursesScreen.id: (context) => ViewCoursesScreen(),
            ViewCourseDetails.id: (context) => ViewCourseDetails(),
            StudentDetailPage.id: (context) => const StudentDetailPage(),
            SubscribeToCourseScreen.id: (context) => SubscribeToCourseScreen(),
            SubscribedCoursesScreen.id: (context) => SubscribedCoursesScreen(),
            RegisterPage.id: (context) => RegisterPage(),
            ViewQr.id: (context) => ViewQr(),
            PdfView.id: (context) => const PdfView(),
            PdfViewScreen.id: (context) => const PdfViewScreen(),
          },
          home: const SplashScreen()),
    );
  }
}

//todo: Handle errors on view course details and all possible errors
//todo: Refactor code to have a global textTheme style called KTextStyle
//todo: When scanning, not just the eligibility, check whether the student has registered for that course
