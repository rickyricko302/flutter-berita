import 'package:flutter/material.dart';

Color primaryColor({required BuildContext context}) {
  return Theme.of(context).primaryColor;
}

Color lightPrimaryColor({required BuildContext context}) {
  return Theme.of(context).primaryColor.withValues(alpha: 0.1);
}
