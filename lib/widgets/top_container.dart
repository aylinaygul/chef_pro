import 'package:flutter/material.dart';

class TopContainer extends StatelessWidget {
  final double height;
  final Widget child;
  final EdgeInsets padding;

  const TopContainer(
      {super.key,
      required this.height,
      required this.child,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 76, 248, 79),
        borderRadius: BorderRadius.zero,
      ),
      height: height,
      child: child,
    );
  }
}
