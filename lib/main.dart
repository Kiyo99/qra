import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/presentation/auth/login_page.dart';
import 'package:qra/presentation/auth/register_page.dart';
import 'package:qra/presentation/staff/scanner/scanner.dart';
import 'package:qra/presentation/staff/staff_page/staff_page.dart';
import 'package:qra/presentation/student/generate/viewQr.dart';
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
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ViewQr.id: (context) => ViewQr(),
        },
        home: user == null ? LoginPage() : const StaffPage(title: "QRA"));
  }
}

//todo: icons, validation,
//todo: catch exception for login and registration, handle them
//todo: lecturer is greeted with a list of available courses for that day (filter by date?, Use current date as query???,
//todo so fetch all but filter by date, meaning the courses should have a date parameter) - tonight
//todo: When lecturer selects a choice, then the app makes a call to firebase to fetch that document. As a list most likely (Or when he makes the call to go to the screen the method is fired, just like delivery app)

//todo: create a screen for adding and deleting courses, (Only lecturers or admins or exam controller)
//todo: there will be a dropdown of courses based on the day. That courses will have ID's as documents. Which will in turn be keys of other stuff
//todo: The student has a screen where he or she adds a course to be taken that semester, then when the staff clicks on that link, it brings in all the student details
//todo: I need to create a model for course as well as students

//todo: How you will automatically check the box is this. There wil be a stream that listens to this shit.
// todo It will update the user data based on the ID. Then the attendance sheet will know that something has changed and rebuild itself
