import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer.rectangle({
    Key? key,
    this.widget,
    this.shape = BoxShape.rectangle,
    this.height,
    this.width,
    this.radius = 8,
    this.padding = 12,
    this.color,
    this.borderColor = const Color(0xffEBEBEB),
    this.constraints,
    this.paddings,
  }) : super(key: key);
  const CustomContainer.circle(
      {Key? key,
      this.widget,
      this.shape = BoxShape.rectangle,
      this.height,
      this.width,
      this.radius = 100,
      this.padding = 0,
      this.color,
      this.borderColor = const Color(0xffEBEBEB),
      this.constraints,
      this.paddings})
      : super(key: key);
  final Widget? widget;
  final double? height, width, radius, padding;
  final BoxShape? shape;
  final Color? color;
  final Color? borderColor;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? paddings;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddings ?? EdgeInsets.all(padding!),
      height: height,
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor!),
          color: color,
          shape: shape!,
          borderRadius: BorderRadius.circular(radius!)),
      constraints: constraints,
      child: widget,
    );
  }
}
