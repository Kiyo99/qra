import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qra/presentation/widgets/prompts.dart';

class AppModal {
  AppModal();

  static void showModal(
      {required BuildContext context,
      required String title,
      required String message,
      required String asset,
      required Function() primaryAction,
      required String buttonText,
      bool? showSecondary}) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        builder: (ctx) => AppPrompts(
            title: title,
            message: message,
            asset: asset,
            primaryAction: primaryAction,
            buttonText: buttonText,
            showSecondary: showSecondary ?? false));
  }


  static void showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: 'Got it', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
