import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:qra/constants.dart';
import 'package:qra/presentation/student/generate/generator_improved.dart';
import 'package:qra/presentation/student/student_options_view.dart';

class StudentPage extends HookWidget {
  const StudentPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.coolBlue,
            title: Text(title),
            bottom: const TabBar(
              tabs: [
                Tab(text: "Generate QR"),
                Tab(text: "Upload courses"),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert_outlined),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    isScrollControlled: true,
                    builder: (ctx) => const StudentOptionsScreen(
                      title: 'Hey there, select an option',
                    ),
                  );
                },
              ),
            ],
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              const ImprovedQrGenerator(),
              Container(
                  color: Colors
                      .blueAccent), //todo this will be the register course part
            ],
          ),
        ));
  }
}
