import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

emptyAppBar(
    {Color? color,
    Brightness? statusBarIconBrightness,
    required BuildContext context}) {
  if (Platform.isIOS) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: color ?? Theme.of(context).primaryColor,
        statusBarBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.dark
            : statusBarIconBrightness ?? Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      elevation: 0,
      backgroundColor: color ?? Theme.of(context).colorScheme.background,
      toolbarHeight: 0,
      shape: const Border(bottom: BorderSide.none),
    );
  } else if (Platform.isAndroid) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : statusBarIconBrightness ?? Brightness.dark,
      ),
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      elevation: 0,
      backgroundColor: color ?? Colors.white,
      toolbarHeight: 0,
      shape: const Border(bottom: BorderSide.none),
    );
  }
}
