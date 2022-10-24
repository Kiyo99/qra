import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/data/app_user/app_user.dart';
import 'package:qra/data/datasource/auth_local_datasource.dart';
import 'package:qra/presentation/auth/intro_screen.dart';
import 'package:qra/presentation/auth/login_page.dart';
import 'package:qra/presentation/auth/register_page.dart';
import 'package:qra/presentation/auth/splash_screen.dart';
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
    final user = ref.read(AuthLocalDataSource.provider).getCachedUser();
    final userr = ref.read(AuthLocalDataSource.provider).viewedIntro();

    print("User is ${user?.iD}");
    print("Usgger is ${userr}");

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
            RegisterPage.id: (context) => RegisterPage(),
            ViewQr.id: (context) => ViewQr(),
          },
          home: const SplashScreen()),
    );
  }
}

//todo: Create a splash screen, and in that splash screen you determine the user destination cos omo
//todo: Take inspiration from pamo and then use the same approach to do the checks

//todo: Add subscribed courses to menu and then fetch the list. Add courses to students model
//todo: Look at either locally caching the person or having useState

//todo: Implement a My courses section?

//todo: try to set light and dark theme
//todo: refactor code to have one text theme, google fonts
//todo: or have like 2 or 3 global text themes in constants and call them from there

//todo: refactor lottie for view normal courses maybe to no internet

//todo: Should the lecturer be able to download pdf of the attendance sheet?
//todo: Handle errors on view course details

//todo: Locally save user
//todo: When registering, 2 options: registering as a student or examiner
//todo: Save that field as status. Now create the userJson model from there and supply the information there
//todo: When logging in, show a loader that shows "Wait amin, setting up workspace" during that time we fetch the doc and determine the user
