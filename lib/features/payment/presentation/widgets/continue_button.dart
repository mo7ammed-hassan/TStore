import 'package:flutter/material.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class ContinueButton extends StatelessWidget {
  final bool enabled;
  final void Function()? onPressed;

  const ContinueButton({
    super.key,
    required this.enabled,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: context.responsiveInsets.all(16),
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const ResponsiveText(
            'Continue',
          ),
        ),
      ),
    );
  }
}
