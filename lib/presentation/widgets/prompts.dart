import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:qra/constants.dart';

class AppPrompts extends HookConsumerWidget {
  const AppPrompts(
      {Key? key,
      required this.title,
      required this.message,
      required this.asset,
      required this.primaryAction,
      required this.buttonText,
      required this.showSecondary})
      : super(key: key);

  final String title;
  final String message;
  final String buttonText;
  final bool showSecondary;
  final String asset;
  final Function() primaryAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
          decoration: BoxDecoration(
            color: Constants.coolBlue,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (showSecondary == true)
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: CircleAvatar(
                      backgroundColor: Constants.coolOrange.withOpacity(.1),
                      foregroundColor: Constants.coolOrange,
                      child: const Icon(Icons.close, size: 20),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Lottie.asset(
                  asset,
                  width: 100,
                  height: 100,
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: primaryAction,
                child: Text(
                  buttonText,
                  style: TextStyle(color: Constants.coolBlue),
                ),
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Constants.coolOrange,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Constants.coolOrange),
              ),
              const SizedBox(height: 10),
              if (showSecondary == true)
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(color: Constants.coolOrange),
                  ),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Constants.coolOrange,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
