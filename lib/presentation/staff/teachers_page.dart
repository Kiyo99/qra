import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/constants.dart';
import 'package:qra/presentation/make_body.dart';

class TeachersPage extends HookConsumerWidget {
  static const id = "/teachers";

  const TeachersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () {
        print("Refreshed!");
        return Future.value(0);
      },
      child: Container(
        color: Constants.coolBlue,
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(const MakeBody());
                print("The index that was tapped is: ${index}");
              },
              //todo: Abstract this into its own class
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(64, 75, 96, .9),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "COSC306",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_vert_outlined,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Intro to Computer Science",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Teacher: Mr Kingsley Arthur",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: 5,
        ),
      ),
    );
  }
}
