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
  bool _isExpanded = false;
  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
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
              IconButton(
                onPressed: _toggleExpansion,
                icon: AnimatedRotation(
                  turns: _isExpanded ? 1 : 0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  child: Icon(
                    size: context.horzSize(21),
                    _isExpanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
                    key: ValueKey<bool>(_isExpanded),
                  ),
                ),
              ),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeInOut,
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            reverseDuration: const Duration(milliseconds: 250),
            child: _isExpanded
                ? Column(
                    children: [
                      ResponsiveGap.vertical(TSizes.spaceBtwItems),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                      const Text('Opend'),
                    ],
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
