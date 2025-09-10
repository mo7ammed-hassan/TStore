import 'package:flutter/material.dart';

class InputCardBox extends StatelessWidget {
  final Widget child;

  const InputCardBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.grey),
        ),
      ),
      child: child,
    );
  }
}