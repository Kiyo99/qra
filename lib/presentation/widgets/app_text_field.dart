import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qra/constants.dart';

class AppTextField extends HookWidget {
  final TextEditingController controller;
  final String title;

  AppTextField({required this.controller, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        cursorColor: Constants.coolOrange,
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Constants.coolOrange)),
            border: const OutlineInputBorder(),
            labelText: title,
            labelStyle: GoogleFonts.exo2(color: Colors.white)),
      ),
    );
  }
}
