import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ViewQr extends HookConsumerWidget {
  static const id = "generatee";

  ViewQr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = useState(Get.arguments);
    final data = Map<String, dynamic>.from(args.value);
    print("Incoming data: ${data}");
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
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
              child: QrImage(
                foregroundColor: Colors.blue.shade900,
                data:
                    "{'Name': '${data['Full name']}', 'ID': '${data['ID']}', 'Eligible': '${data['isEligible']}'}",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
