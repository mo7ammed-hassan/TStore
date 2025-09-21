import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/checkbox/custom_checkbox.dart';
import 'package:t_store/core/core.dart';

class OptionCheckbox extends StatelessWidget {
  const OptionCheckbox({
    super.key,
    required this.value,
    required this.title,
    this.onChanged,
  });
  final String title;
  final bool value;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Row(
      children: [
        CustomCheckbox(
          value: value,
          fillColor: value
              ? null
              : WidgetStatePropertyAll(
                  isDark ? Colors.white12 : Colors.black12,
                ),
          side: BorderSide.none,
          onChanged: onChanged,
          size: 16,
        ),
        const SizedBox(width: 8),
        ResponsiveText(
          title,
          maxLines: 2,
          fontSize: 12.8,
          fontWeight: FontWeight.w400,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ],
    );
  }
}
