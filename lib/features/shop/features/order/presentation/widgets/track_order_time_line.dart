import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/core.dart';

class TrackOrderTimeline extends StatelessWidget {
  const TrackOrderTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final textTheme = Theme.of(context).textTheme;

    final steps = [
      const _OrderStepData(
        title: 'Order Placed',
        subtitle: 'We have received your order on 20-Dec-2019',
        icon: Iconsax.receipt_1,
        color: Colors.orange,
        isCompleted: true,
      ),
      const _OrderStepData(
        title: 'Order Confirmed',
        subtitle: 'We have confirmed your order on 20-Dec-2019',
        icon: Iconsax.verify,
        color: Colors.orange,
        isCompleted: true,
      ),
      const _OrderStepData(
        title: 'Order Processed',
        subtitle: 'We are preparing your order',
        icon: Iconsax.box,
        color: Colors.green,
        isCompleted: true,
      ),
      const _OrderStepData(
        title: 'Ready to Ship',
        subtitle: 'Your order is ready for shipping',
        icon: Iconsax.truck_fast,
        color: Colors.grey,
        isCompleted: false,
      ),
      const _OrderStepData(
        title: 'Out for Delivery',
        subtitle: 'Your order is out for delivery',
        icon: Iconsax.location,
        color: Colors.grey,
        isCompleted: false,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        steps.length,
        (index) {
          final step = steps[index];
          final isLast = index == steps.length - 1;

          // Determine line color based on current + next step
          final nextStepCompleted = !isLast && steps[index + 1].isCompleted;
          final lineColor = (step.isCompleted && nextStepCompleted)
              ? step.color
              : Colors.grey.shade300;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Line connecting steps
                  Column(
                    children: [
                      // circle
                      Container(
                        width: context.horzSize(13),
                        height: context.horzSize(13),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: step.isCompleted
                              ? step.color
                              : Colors.grey.shade300,
                        ),
                      ),
                      // line
                      if (!isLast)
                        Container(
                          width: 2.26,
                          height: context.vertSize(85),
                          color: lineColor,
                        ),
                    ],
                  ),
                  // icon
                  Container(
                    padding: context.responsiveInsets.all(9),
                    margin: context.responsiveInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: step.isCompleted ? step.color : Colors.grey[300],
                    ),
                    child: Icon(
                      step.icon,
                      size: context.horzSize(26),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              // Right content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveText(
                      step.title,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.5,
                        color: step.isCompleted
                            ? step.color
                            : (isDark ? Colors.white70 : Colors.grey),
                      ),
                    ),
                    ResponsiveGap.vertical(4),
                    ResponsiveText(
                      step.subtitle,
                      maxLines: 3,
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: 13.6,
                        color: isDark ? Colors.grey.shade400 : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _OrderStepData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isCompleted;

  const _OrderStepData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.isCompleted,
  });
}
