import 'package:flutter/material.dart';

class MyRedButton extends StatelessWidget {
  const MyRedButton({super.key, required this.text, required this.onPresss});
  final String text;
  final VoidCallback onPresss;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: onPresss,
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
