import 'package:flutter/material.dart';

class ConfirmPaymentButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onPressed;

  const ConfirmPaymentButton({
    super.key,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text("Confirm Payment", style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
