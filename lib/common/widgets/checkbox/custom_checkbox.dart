import 'package:flutter/material.dart';
import 'package:t_store/core/core.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    this.onChanged,
    this.value,
    this.fillColor,
    this.side,
    this.size,
  });
  final bool? value;
  final void Function(bool?)? onChanged;
  final WidgetStateProperty<Color?>? fillColor;
  final BorderSide? side;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? context.horzSize(24),
      height: size ?? context.horzSize(24),
      child: Center(
        child: Checkbox(
          fillColor: fillColor,
          side: side,
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
