import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanner extends HookConsumerWidget {
  static const id = "scanner";

  const QrScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String g = "{'Name': Godsfavour Kio, 'ID': 218cs01004885, 'Eligible': false}";
    // dynamic data = {'Name': 'Godsfavour Kio', 'ID': '218cs01004885', 'Eligible': 'false'};
    final dynamic data = json.decode(json.encode(g));
    // final dd = Map<String, dynamic>.from(data);
    debugPrint('Bardddddddddd! ${data}');

    return MobileScanner(
        allowDuplicates: false,
        onDetect: (barcode, args) {
          if (barcode.rawValue == null) {
            debugPrint('Failed to scan Barcode');
          } else {
            final dynamic code = barcode.rawValue!;
            debugPrint('Barcode found! $code');
            final Map data = json.decode(json.encode(code));
            debugPrint('Bardddddddddd! $data');
            if (data['ID'] == '218CS01004885'
                ) {
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

//todo; find a way to change the string to a map