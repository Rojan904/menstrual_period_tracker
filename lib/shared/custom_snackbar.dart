import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:menstraul_period_tracker/shared/global.dart';

class CustomSnackbar {
  static buildSnackbar(BuildContext context, String message, String title,
      ContentType contentType) {
    snackbarKey.currentState?.showSnackBar(
      SnackBar(
        content: AwesomeSnackbarContent(
            title: title, message: message, contentType: contentType),
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 2000),
        elevation: 0,
      ),
    );
  }
}
