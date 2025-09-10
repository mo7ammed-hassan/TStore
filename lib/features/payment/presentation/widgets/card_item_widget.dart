import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text_span.dart';

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      padding: context.responsiveInsets.symmetric(horizontal: 12, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Card Header (Name + Number + Type) ---
          _CardHeader(isDark: isDark),

          ResponsiveGap.vertical(20),

          /// --- Expire Date ---
          ResponsiveTextSpan(
            text: 'Expire Date:',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
            children: const [
              ResponsiveTextSpan(
                text: ' 07/28',
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),

          ResponsiveGap.vertical(24),

          /// --- Primary Card Indicator ---
          const _PrimaryCardIndicator(),

          ResponsiveGap.vertical(24),

          /// --- Actions (Delete / Update) ---
          const _CardActions(),
        ],
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Card Holder Name & Number
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ResponsiveText(
                'Mohamed Hassan',
                // Using Theme for consistency
              ),
              ResponsiveGap.vertical(8),
              const ResponsiveText(
                'xxxx xxxx 4512',
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ],
          ),
        ),

        /// Card Type (e.g. VISA, MasterCard)
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkerGrey : AppColors.light,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: context.responsiveInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          child: const Center(
            child: ResponsiveText(
              'VISA',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _PrimaryCardIndicator extends StatefulWidget {
  const _PrimaryCardIndicator();

  @override
  State<_PrimaryCardIndicator> createState() => _PrimaryCardIndicatorState();
}

class _PrimaryCardIndicatorState extends State<_PrimaryCardIndicator> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() {
            _selected = !_selected;
          }),
          child: AnimatedContainer(
            width: context.horzSize(_selected ? 21 : 18.5),
            height: context.horzSize(_selected ? 21 : 18.5),
            padding: const EdgeInsets.all(6),
            duration: const Duration(milliseconds: 300),
            decoration: ShapeDecoration(
              shape: CircleBorder(
                  side: BorderSide(
                color: _selected ? Colors.transparent : Colors.grey,
              )),
              color: _selected ? AppColors.primary : null,
            ),
            child: const DecoratedBox(
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ResponsiveText(
          'Primary Card',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class _CardActions extends StatelessWidget {
  const _CardActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Delete
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const ResponsiveText(
              'Delete Card',
              fontSize: 13,
            ),
          ),
        ),
        ResponsiveGap.horizontal(14),

        /// Update Expiry
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const ResponsiveText(
              'Update Expire Date',
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
