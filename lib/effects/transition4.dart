import 'package:flutter/material.dart';

class SizeTransition4 extends PageRouteBuilder {
  final Widget page;

  SizeTransition4(this.page)
      : super(
    pageBuilder: (context, animation, anotherAnimation) => page,
    transitionDuration: Duration(milliseconds: 1000),
    reverseTransitionDuration: Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
      animation = CurvedAnimation(
          curve: Curves.fastLinearToSlowEaseIn,
          parent: animation,
          reverseCurve: Curves.fastOutSlowIn);
      return Align(
        alignment: Alignment.centerLeft,
        child: SizeTransition(
          axis: Axis.horizontal,
          sizeFactor: animation,
          child: page,
          axisAlignment: 0,
        ),
      );
    },
  );
}