import 'package:flutter/material.dart';
import 'package:info_a1/core/util.dart';

class MyPrimaryButton extends StatelessWidget {
  const MyPrimaryButton({
    super.key,
    required this.text,
    required this.onPresss,
  });
  final String text;
  final VoidCallback onPresss;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor(context: context),
        ),
        onPressed: onPresss,
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
