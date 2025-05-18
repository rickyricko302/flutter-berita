import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
    bodyFontString,
    baseTextTheme,
  );
  TextTheme displayTextTheme = GoogleFonts.getTextTheme(
    displayFontString,
    baseTextTheme,
  );
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}

Color primaryColor({required BuildContext context}) {
  return Theme.of(context).colorScheme.primary;
}

Color secondaryColor({required BuildContext context}) {
  return Theme.of(context).colorScheme.secondary;
}

TextStyle? displayLarge({required BuildContext context}) {
  return Theme.of(context).textTheme.displayLarge;
}

TextStyle? displaySmall({required BuildContext context}) {
  return Theme.of(context).textTheme.displaySmall;
}

TextStyle? titleLarge({required BuildContext context}) {
  return Theme.of(context).textTheme.titleLarge;
}

TextStyle? bodySmall({required BuildContext context}) {
  return Theme.of(context).textTheme.bodySmall;
}

showSnackbarError(title, message) {
  Get.snackbar(
    title,
    message,
    backgroundColor: Theme.of(Get.context!).colorScheme.error,
    colorText: Colors.white,
  );
}

showSnackbarSuccess(title, message) {
  Get.snackbar(
    title,
    message,
    backgroundColor: Colors.green,
    colorText: Colors.white,
  );
}
