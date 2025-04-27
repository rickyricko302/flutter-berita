import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.textEditingController,
    this.hint,
    this.prefix,
    this.maxLine,
    this.enabled,
  });
  final TextEditingController textEditingController;
  final String? hint;
  final Widget? prefix;
  final int? maxLine;
  final bool? enabled;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      enabled: enabled,
      maxLines: maxLine,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.withValues(alpha: 0.1),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIcon: prefix,
      ),
    );
  }
}
