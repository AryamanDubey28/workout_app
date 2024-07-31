import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PlatformSpecificButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final VoidCallback? onPressed;

  const PlatformSpecificButton(
      {super.key,
      required this.child,
      required this.onPressed,
      this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoButton(
        color: color,
        onPressed: onPressed,
        child: child,
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: color,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: child,
      );
    }
  }
}
