import 'package:flutter/material.dart';

loading(BuildContext context) {
  return showDialog(
      barrierColor: Colors.white.withOpacity(0.8),
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return const Center(child: CircularProgressIndicator());
      });
}
