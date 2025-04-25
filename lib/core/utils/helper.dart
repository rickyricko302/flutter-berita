import 'package:flutter/material.dart';

class Helper {
  // Fungsi untuk melakukan push halaman
  // [Required params] => BuildContext, Widget
  static pushPage({required BuildContext context, required Widget page}) {
    return Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (builder) => page));
  }

  static backFirstPage({required BuildContext context}) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  static double getTextWidth({
    required String text,
    required TextStyle? textStyle,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }
}
