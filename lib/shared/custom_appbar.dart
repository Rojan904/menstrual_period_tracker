import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

appBar(Widget title, context, {ShapeBorder? shape}) {
  dynamic statusBarIconBrightness;
  return AppBar(
      scrolledUnderElevation: 0,
      systemOverlayStyle: Platform.isIOS
          ? SystemUiOverlayStyle(
              statusBarBrightness:
                  Theme.of(context).brightness == Brightness.dark
                      ? Brightness.dark
                      : statusBarIconBrightness ?? Brightness.light,
              statusBarIconBrightness: Brightness.light,
            )
          : SystemUiOverlayStyle(
              statusBarColor: Theme.of(context).colorScheme.background,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness:
                  Theme.of(context).brightness == Brightness.dark
                      ? Brightness.light
                      : statusBarIconBrightness ?? Brightness.dark,
            ),
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      elevation: 0,
      // backgroundColor: Colors.white,
      title: title,
      shape: shape ?? Theme.of(context).appBarTheme.shape);
}
