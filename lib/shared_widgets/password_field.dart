import 'package:flutter/material.dart';

class MyPasswordField extends StatefulWidget {
  const MyPasswordField({
    super.key,
    required this.placeholder,
    required this.textEditingController,
  });
  final String placeholder;
  final TextEditingController textEditingController;
  @override
  State<MyPasswordField> createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  bool isPasswordShow = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      obscureText: !isPasswordShow,
      decoration: InputDecoration(
        labelText: widget.placeholder,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isPasswordShow = !isPasswordShow;
            });
          },
          icon: Icon(
            !isPasswordShow ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
        ),
        filled: true,
        fillColor: Colors.grey.withValues(alpha: 0.1),
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
      ),
    );
  }
}
