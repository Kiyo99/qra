import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qra/data/fb_student_model/student_model.dart';
import 'package:qra/data/scanner/scanner_model.dart';

class QrScanner extends HookConsumerWidget {
  static const id = "scanner";

  const QrScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // String stringifiedJson =
    //     "{\n \"name\" : \"Godsfavour Kio \",\n  \"iD\" : \"218cs01004885 \",\n \"eligible\" : \"false\"}";
    //
    // final dynamic dataa = jsonDecode(stringifiedJson);
    // // final dd = Map<String, dynamic>.from(data);
    // final data = FbModel.fromJson(dataa);
    // debugPrint('Bardddddddddd! ${data.name}');

    return MobileScanner(
        allowDuplicates: false,
        onDetect: (barcode, args) {
          if (barcode.rawValue == null) {
            debugPrint('Failed to scan Barcode');
          } else {
            final String code = barcode.rawValue!;
            debugPrint('Barcode found! $code');

            // final Map<String, dynamic> data = json.decode(code);
            // print("Dat is: $data");

            final codd = ScannerModel.fromJson(json.decode(code));
            debugPrint('Barcodeeee found! ${codd}');
            debugPrint('Nameee found! ${codd.name}');
            debugPrint('Idd found! ${codd.iD}');
            debugPrint('ELigible found! ${codd.eligible}');


            // final Map data = json.decode(json.encode(code));
            // debugPrint('Barddddddfffdddd! $data');
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