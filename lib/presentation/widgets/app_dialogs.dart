import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class AppDialogs {
  static _dialog({
    required Widget body,
    Widget? title,
    List<Widget>? actions,
    dismissible = false,
  }) {
    return Get.dialog(
      PlatformAlertDialog(
        title: title,
        content: body,
        actions: actions,
      ),
      barrierDismissible: dismissible,
    );
  }

  static showWelcomeUserDialog(String name, String message,
      {Function()? onPressed}) {
    _dialog(
      title: CircleAvatar(
        child: Image.asset('assets/images/logo_ripple.png'),
        radius: 35,
      ),
      dismissible: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Welcome $name",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 15),
          Text(
            message,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7)),
          ),
        ],
      ),
      actions: [
        PlatformDialogAction(
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 20,
                    child: Divider(
                      thickness: 1.0,
                    )),
              ),
              Text(
                "Great!",
                style: TextStyle(
                    fontSize: 18, color: Colors.black.withOpacity(0.7)),
              ),
            ],
          )),
          onPressed: onPressed,
        ),
      ],
    );
  }

  static showConfirmationDialog({
    required String title,
    required String message,
    required String primaryActionLabel,
  }) {
    return _dialog(
      title: Text(title),
      body: Text(message),
      actions: [
        PlatformDialogAction(
          onPressed: () => Get.back(result: 'Cancel'),
          child: const Text('Cancel'),
        ),
        PlatformDialogAction(
          onPressed: () => Get.back(result: 'Agree'),
          child: Text(primaryActionLabel),
        )
      ],
    );
  }

  static showGeneralDialog({
    required String message,
    required List<Widget> actions,
  }) {
    _dialog(body: Text(message), title: const Text("Alert!"), actions: actions);
  }

  static showDeliveryConfirmation() {
    return _dialog(
      title: const Text("Confirm receipt?"),
      body: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text.rich(
          TextSpan(
            text: "By ",
            children: [
              TextSpan(
                text: "confirming receipt, ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: "you agree to have received the item "
                    "and your account will be debited.",
              ),
            ],
          ),
        ),
      ),
      actions: [
        PlatformDialogAction(
          child: const Text("Confirm"),
          onPressed: () => Get.back(result: true),
        ),
        PlatformDialogAction(
          child: const Text("Cancel"),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }

  static showPromptDialog({
    required String message,
    required Function() onActionClicked,
    String label = "Yes",
  }) {
    _dialog(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(message),
      ),
      title: const Text("Action required!"),
      actions: [
        PlatformDialogAction(
          child: const Text("Cancel"),
          onPressed: () => Get.back(),
        ),
        PlatformDialogAction(
          child: Text(label, style: const TextStyle(color: Colors.red)),
          onPressed: onActionClicked,
        ),
      ],
    );
  }

  static showAlert({
    String title = "Action required!",
    String actionLabel = "Okay",
    bool? showCancel = false,
    required String message,
    required Function() onActionClicked,
  }) {
    return _dialog(
      dismissible: false,
      title: Text(title),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(message),
      ),
      actions: [
        PlatformDialogAction(
          child: Text(actionLabel),
          onPressed: onActionClicked,
        ),
        if (showCancel == true)
          PlatformDialogAction(
            child: Text("Cancel"),
            onPressed: () {
              Get.back();
            },
          ),
      ],
    );
  }

  static success(String message) {
    return _dialog(
      title: SizedBox(
        height: 40,
        child: Lottie.asset(
          "assets/lottie/success.json",
          frameRate: FrameRate(60),
        ),
      ),
      body: Text(message),
      actions: [
        PlatformDialogAction(
          child: const Text("Okay!"),
          onPressed: () => Get.back(result: "OK"),
        ),
      ],
    );
  }

  static wishCreated(String title, String message) {
    return _dialog(
      title: SizedBox(
        height: 40,
        child: Lottie.asset(
          "assets/lottie/success.json",
          frameRate: FrameRate(60),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        PlatformDialogAction(
          child: const Text("Okay!"),
          onPressed: () => Get.back(result: "OK"),
        ),
      ],
    );
  }

  static deleted(message) {
    return _dialog(
      title: SizedBox(
        height: 40,
        child: Lottie.asset(
          "assets/lottie/bin.json",
          frameRate: FrameRate(60),
        ),
      ),
      body: Text("$message"),
      actions: [
        PlatformDialogAction(
          child: const Text("Okay!"),
          onPressed: () => Get.back(result: "OK"),
        ),
      ],
    );
  }

  static error(message) {
    return _dialog(
      title: SizedBox(
        height: 40,
        child: Lottie.asset(
          "assets/lottie/error.json",
          frameRate: FrameRate(60),
        ),
      ),
      body: Text(message),
      actions: [
        PlatformDialogAction(
          child: const Text("Okay!"),
          onPressed: () => Get.back(result: "OK"),
        ),
      ],
    );
  }

  static info(message) {
    return _dialog(
      title: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.deepOrange.shade50,
            radius: 20,
            child: const Icon(
              Icons.info_outlined,
              size: 35,
              color: Colors.deepOrange,
            ),
          ),
          const SizedBox(height: 10),
          const Text("Heya!"),
        ],
      ),
      body: Text(message),
      actions: [
        PlatformDialogAction(
          child: const Text("Okay!"),
          onPressed: () => Get.back(result: "OK"),
        ),
      ],
    );
  }

  static warning(
    message, {
    String actionText = "Okay!",
    bool hasCancel = false,
  }) {
    return _dialog(
      title: const SizedBox(
        height: 40,
        child: Icon(Icons.warning, size: 35, color: Colors.orangeAccent),
      ),
      dismissible: true,
      body: Text(message),
      actions: [
        if (hasCancel)
          PlatformDialogAction(
            child: Text("Stay here"),
            onPressed: () => Get.back(result: "Cancel"),
          ),
        PlatformDialogAction(
          child: Text(actionText),
          onPressed: () => Get.back(result: "OK"),
        ),
      ],
    );
  }

  static lottieLoader() {
    return Get.dialog(
      Transform.scale(
        scale: 1,
        child: Lottie.asset(
          "assets/lottie/loader.json",
          frameRate: FrameRate(60),
        ),
      ),
      barrierDismissible: true,
    );
  }

  static customLottie(String lottie, double scale) {
    Get.dialog(
      Transform.scale(
        scale: scale,
        child: Lottie.asset(
          lottie,
          frameRate: FrameRate(60),
        ),
      ),
      barrierDismissible: true,
    );
  }

  static lottieSuccess(message) {
    Get.dialog(
      Transform.scale(
        scale: .23,
        child: Lottie.asset(
          "assets/lottie/success.json",
          frameRate: FrameRate(60),
        ),
      ),
      barrierDismissible: false,
    );
  }
}

enum ConfirmAction { CONFIRM, CANCEL }
