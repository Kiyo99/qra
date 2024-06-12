import 'dart:convert';

import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/student_model/student_model.dart';

class ViewQr extends HookConsumerWidget {
  static const id = "generatee";

  ViewQr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = useState(Get.arguments);
    final data = Map<String, dynamic>.from(args.value);
    final studentData = StudentModel.fromJson(data);

    final studentDetailsToSend = {
      "name" : studentData.fullName,
      "iD": studentData.iD,
      "eligible": studentData.isEligible,
      "courses": args.value['courses'],
    };
    // print(studentData);
    return DismissiblePage(
      dragSensitivity: .4,
      maxTransformValue: 4,
      direction: DismissiblePageDismissDirection.vertical,
      maxRadius: 0,
      minRadius: 0,
      onDismissed: () => Get.back(),
      child: Scaffold(
        backgroundColor: Constants.coolBlue,
        body: SafeArea(
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(left: 43),
              height: MediaQuery.of(context).size.height / 2.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                width: 400,
                child: QrImageView(
                  foregroundColor: Colors.blue.shade900,
                  data: json.encode(studentDetailsToSend),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
