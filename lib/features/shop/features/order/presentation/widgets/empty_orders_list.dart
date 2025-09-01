import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class EmptyOrdersList extends StatelessWidget {
  const EmptyOrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Flexible(
            flex: 2,
            child: Lottie.asset(TImages.packaging),
          ),
          const ResponsiveText('No orders yet'),
          ResponsiveGap.vertical(8),
          const ResponsiveText(
            'Your orders will appear here once you make a purchase.',
            textAlign: TextAlign.center,
            maxLines: 5,
            fontSize: 13,
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}