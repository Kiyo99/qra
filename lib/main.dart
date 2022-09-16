import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/attendance/attendance_page.dart';
import 'package:qra/presentation/auth/login_page.dart';
import 'package:qra/presentation/auth/register_page.dart';
import 'package:qra/presentation/generate/generator.dart';
import 'package:qra/presentation/generate/viewQr.dart';
import 'package:qra/presentation/scanner/scanner.dart';
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
      child: const MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    return GetMaterialApp(
      // useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      title: 'QRA',
      debugShowCheckedModeBanner: false,
      routes: {
        QrScanner.id: (context) => const QrScanner(),
        QrGenerator.id: (context) => const QrGenerator(),
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ViewQr.id: (context) => ViewQr(),
      },
      home: user == null? LoginPage() : const AttendancePage(title: "QRA")
    );
  }
}

//todo: icons, validation,
//todo: catch exception for login and registration, handle them
//todo: generate list for UI
//todo: figure out backend for scanning
//todo: Lecturer should be able to select which course he wants to mark attendance for
//todo: lecturer is greeted with a list of available courses for that day (Use current date as query???)
//todo: When lecturer selects a choice, then the app makes a call to firebase to fetch that document. As a list most likely
//todo: List tile should have a checkbox.
//todo: List details should contain Name of student, ID, Level,

//todo: create a screen for adding and deleting courses,
//todo: create a screen for viewing courses,
//todo: there will be a drodpown of courses based on the day. That courses will have ID's as documents. Which will in turn be keys of other stuff
//todo: The student has a screen where he or she adds a course to be taken that semester, then when the staff clicks on that link, it brings in all the student details
//todo: I need to create a model for course as well as students
