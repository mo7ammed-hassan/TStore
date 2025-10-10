import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/core.dart';

class ExpandableTrackOrderSection extends StatefulWidget {
  const ExpandableTrackOrderSection({
    super.key,
  });

  @override
  State<ExpandableTrackOrderSection> createState() =>
      _ExpandableTrackOrderSectionState();
}

class _ExpandableTrackOrderSectionState
    extends State<ExpandableTrackOrderSection> {
  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);
  void _toggleExpansion() {
    _isExpanded.value = !_isExpanded.value;
  }

  @override
  void dispose() {
    _isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = HelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(left: TSizes.spaceBtwItems),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ResponsiveText(
                  'Track Order',
                  style: textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.grey : const Color(0xFF5a5e64),
                    fontSize: 14.2,
                  ),
                ),
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: _isExpanded,
                  builder: (context, isExpanded, _) {
                    return IconButton(
                      onPressed: _toggleExpansion,
                      icon: AnimatedRotation(
                        turns: isExpanded ? 1 : 0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        child: Icon(
                          size: context.horzSize(21),
                          isExpanded
                              ? Iconsax.arrow_up_2
                              : Iconsax.arrow_down_1,
                          key: ValueKey<bool>(isExpanded),
                        ),
                      ),
                    );
                  }),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeInOut,
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            reverseDuration: const Duration(milliseconds: 250),
            child: ValueListenableBuilder<bool>(
              valueListenable: _isExpanded,
              builder: (context, isExpanded, _) {
                return isExpanded
                    ? Column(
                        children: [
                          ResponsiveGap.vertical(TSizes.spaceBtwItems),
                          for (int i = 0; i < 10; i++) const Text('Opened'),
                        ],
                      )
                    : const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
