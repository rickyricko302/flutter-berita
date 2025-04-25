import 'package:flutter/material.dart';

class MyButtonPrimary extends StatelessWidget {
  const MyButtonPrimary({super.key, required this.onPress, required this.text});
  final Function()? onPress;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
      onPressed: onPress,
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }
}
