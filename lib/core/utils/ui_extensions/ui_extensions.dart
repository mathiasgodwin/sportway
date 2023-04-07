import 'package:flutter/material.dart';

extension UIExtension on BuildContext {
  Future<void> showLoading() async {
    return showDialog(
        context: this,
        barrierDismissible: true,
        builder: (context) {
          return WillPopScope(
            //TODO: Change barrierDismissible and onWillPop to false
            onWillPop: () => Future.value(true),
            child: Dialog(
              backgroundColor: Colors.transparent.withOpacity(.2),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Theme.of(this).primaryColor,
                  strokeWidth: 8,
                )),
              ),
            ),
          );
        });
  }

  Future<void> showErrorMessage(String error, {int? duration}) async {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(error),
        duration: duration == null
            ? const Duration(seconds: 3)
            : Duration(seconds: duration),
      ));
  }

  Future<void> showSuccessMessage(String message, {int? duration}) async {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(message),
        duration: duration == null
            ? const Duration(seconds: 3)
            : Duration(seconds: duration),
      ));
  }
}
