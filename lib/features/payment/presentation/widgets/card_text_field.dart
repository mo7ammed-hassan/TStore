import 'package:flutter/material.dart';

class CardTextField extends StatelessWidget {
  final String? hint;
  final bool enabled;
  final int? maxLength;
  final bool obscureText;
  final TextEditingController? controller;

  const CardTextField({
    super.key,
    this.hint,
    this.enabled = true,
    this.maxLength,
    this.obscureText = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      obscureText: obscureText,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        counterText: '',
        enabled: enabled,
      ),
    );
  }
}
