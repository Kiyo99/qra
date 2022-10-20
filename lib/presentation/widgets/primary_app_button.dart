import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qra/constants.dart';

class PrimaryAppButton extends HookWidget {
  const PrimaryAppButton(
      {Key? key, required this.title, required this.onPressed})
      : super(key: key);
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: GoogleFonts.exo2(
            color: Constants.blueish, fontWeight: FontWeight.w600),
      ),
      style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: Constants.coolOrange,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Constants.coolOrange),
    );
  }
}
