import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qra/data/scanner/scanner_model.dart';

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

            final codd = ScannerModel.fromJson(json.decode(code));
            debugPrint('Barcodeeee found! ${codd}');
            debugPrint('Nameee found! ${codd.name}');
            debugPrint('Idd found! ${codd.iD}');
            debugPrint('ELigible found! ${codd.eligible}');


            if (codd.eligible == "false") {
              Get.back();
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(title: Text("${codd.name}is Eligible to write this paper"));
                  });
              //todo: Find a way to mark the attendance sheet from here
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(title: Text("Inavlid data coming to the examinationg hall"));
                  });
            }
          }
        });
  }
}

//todo; find a way to change the string to a map
