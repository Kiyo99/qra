import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
      home: user == null? LoginPage() : QrGenerator()
    );
  }
}

//todo: icons, validation,
//todo: catch exception for login and registration
//todo: generate list for UI
//todo: figure out backend for scanning
//todo: Lecturer should be able to select which course he wants to mark attendance for
//todo: lecturer is greeted with a list of available courses for that day (Use current date as query???)
//todo: When lecturer selects a choice, then the app makes a call to firebase to fetch that document. As a list most likely
//todo: List tile should have a checkbox.
//todo: List details should contain Name of student, ID, Level,
