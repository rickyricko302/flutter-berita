import 'package:flutter/material.dart';
import 'package:udb_news/core/utils/constants.dart';

class MyAlertError extends StatelessWidget {
  const MyAlertError({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: lightPrimaryColor(context: context),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: primaryColor(context: context),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
