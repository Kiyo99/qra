import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  //colors
  static Color blueish = const Color(0xff181D3D);
  // static Color secondaryBlue = const Color.fromRGBO(64, 75, 96, .9);
  // static Color coolBlue = const Color(0xff111111);
  static Color coolBlue = const Color(0xff1f1f1f);
  static Color coolGrey = const Color(0xffbfbfbf);
  static Color coolWhite = const Color(0xfff9f9f9);

  // static Color coolBlue = const Color(0xff1c1b1b);
  static Color secondaryBlue = const Color(0xff111111);
  // static Color coolBlue = const Color(0xff3A4256);
  // static Color coolBlack = const Color(0xff111111);
  // static Color coolBlue = Colors.deepPurpleAccent;
  static Color coolOrange = const Color(0xffff9933);
  static Color coolRed = const Color(0xff742525);
  static const WHATSAPP = '+233235833345';

  //Toast
  static void showToast(BuildContext context, String message) {
    final brightness = Theme.of(context).brightness;
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: coolWhite),
        ),
        action: SnackBarAction(
          label: 'Got it',
          textColor: coolWhite,
          onPressed: scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }

  // Pref keys
  static const prefsUserKey = 'PREFS_USER_KEY';
  static const prefsViewedKey = 'PREFS_VIEWED_KEY';

  //themes
  static final ThemeData darkTheme = ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: coolBlue,
          selectedItemColor: Constants.coolOrange,
          unselectedItemColor: Colors.grey,
          elevation: 0),
      cardTheme: CardTheme(color: coolBlue),
      appBarTheme: AppBarTheme(
          backgroundColor: coolBlue,
          iconTheme: IconThemeData(color: coolWhite),
          titleTextStyle: GoogleFonts.exo2(color: coolWhite, fontSize: 20)),
      primaryColor: coolBlue,
      bottomAppBarColor: coolBlue,
      scaffoldBackgroundColor: coolBlue,
      colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: coolOrange,
          background: coolBlue,
          brightness: Brightness.dark,
          primary: coolBlue));

  static final ThemeData lightTheme = ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: coolWhite,
          selectedItemColor: Constants.coolOrange,
          unselectedItemColor: Colors.grey,
          elevation: 0),
      appBarTheme: AppBarTheme(
          backgroundColor: coolOrange,
          iconTheme: IconThemeData(color: coolBlue),
          titleTextStyle: GoogleFonts.exo2(color: coolBlue, fontSize: 20)),
      bottomAppBarColor: coolWhite,
      scaffoldBackgroundColor: coolWhite,
      colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: coolOrange,
          background: coolWhite,
          brightness: Brightness.light,
          primary: coolWhite));
}
