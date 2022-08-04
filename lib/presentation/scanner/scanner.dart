import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanner extends HookConsumerWidget {
  static const id = "scanner";

  const QrScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MobileScanner(
        allowDuplicates: false,
        onDetect: (barcode, args) {
          if (barcode.rawValue == null) {
            debugPrint('Failed to scan Barcode');
          } else {
            final String code = barcode.rawValue!;
            debugPrint('Barcode found! $code');
            if (code ==
                "Name: Kio Godsfavour, ID: 218CS0104885, Eligible: True") {
              Get.back();
              showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(title: Text("Go in"));
                  });
            }
            else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(title: Text(code));
                  });
            }
          }
        });
  }
}
