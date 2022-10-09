import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:qra/constants.dart';
import 'package:qra/presentation/student/generate/generator_improved.dart';

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
                  //bring up dialog for Getting settings, log out, update info, etc
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
