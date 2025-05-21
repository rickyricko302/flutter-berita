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

TextStyle? bodyNormal({required BuildContext context}) {
  return Theme.of(context).textTheme.bodyLarge;
}

TextStyle? labelLarge({required BuildContext context}) {
  return Theme.of(context).textTheme.labelLarge;
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

String timeAgo(String isoString) {
  DateTime inputTime = DateTime.parse(isoString).toLocal();
  DateTime now = DateTime.now();
  Duration difference = now.difference(inputTime);

  if (difference.inMinutes < 1) {
    return "Baru saja";
  } else if (difference.inMinutes < 60) {
    return "${difference.inMinutes} menit yang lalu";
  } else if (difference.inHours < 24) {
    return "${difference.inHours} jam yang lalu";
  } else {
    return "${difference.inDays} hari yang lalu";
  }
}
