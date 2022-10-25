import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qra/constants.dart';

class AppTextField extends HookWidget {
  final TextEditingController controller;
  final String title;
  final bool? obscureText;

  AppTextField(
      {required this.controller, required this.title, this.obscureText});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        obscureText: obscureText ?? false,
        cursorColor: Constants.coolOrange,
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(
                15.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
                borderSide: BorderSide(color: Constants.coolOrange)),
            border: const OutlineInputBorder(),
            labelText: title,
            labelStyle: GoogleFonts.exo2(color: Colors.white)),
      ),
    );
  }
}
