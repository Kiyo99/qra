import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';

class IntroPagerItem extends HookWidget {
  final IntroPagerModel slide;

  const IntroPagerItem({Key? key, required this.slide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Lottie.asset(slide.lottiePath),
        ),
        Text(
          slide.title,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
            child: Text(
              slide.description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            )),
      ],
    );
  }
}

class IntroPagerModel {
  final String lottiePath;
  final String title;
  final String description;

  const IntroPagerModel({
    Key? key,
    required this.lottiePath,
    required this.title,
    required this.description,
  });

  static List<IntroPagerModel> get slides => [
        const IntroPagerModel(
          lottiePath: "assets/lottie/hello_robo.json",
          title: "Okay, let's do this.",
          description:
              "Welcome to the QRA, your number 1 go-to app for examinations. Let's have a quick walkthrough, shall we?",
        ),
        const IntroPagerModel(
          lottiePath: "assets/lottie/intro_exam.json",
          title: "Writing Exams.",
          description:
              "As a student, writing exams is inevitable. So wouldn't it be amazing if you had an organized attendance checking system?",
        ),
        const IntroPagerModel(
          lottiePath: "assets/lottie/intro_attendance.json",
          title: "Enter the QRA",
          description:
              "Checking for financial status before exams has never been this easy. Taking attendance of students who come to write exam has been made magical.",
        ),
        const IntroPagerModel(
          lottiePath: "assets/lottie/intro_qr.json",
          title: "Get scanned",
          description:
              "All you have to do is subscribe to a course, generate your QR code and get it scanned by the invigilator. QRA will do the rest!",
        ),
      ];
}
