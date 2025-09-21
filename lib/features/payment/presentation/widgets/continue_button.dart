import 'package:flutter/material.dart';
import 'package:t_store/core/core.dart';

class ContinueButton extends StatelessWidget {
  final Widget? child;
  final bool enabled;
  final bool loading;
  final void Function()? onPressed;

  const ContinueButton({
    super.key,
    required this.enabled,
    this.onPressed,
    this.child,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: context.responsiveInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: enabled ? onPressed : null,
            child: loading
                ? SizedBox(
                    width: context.horzSize(20),
                    height: context.horzSize(20),
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.2,
                      color: Colors.white,
                    ),
                  )
                : const ResponsiveText(
                    'Continue',
                  ),
          ),
        ),
      ),
    );
  }
}
