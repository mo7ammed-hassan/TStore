import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';

class ShimmerListTile extends StatelessWidget {
  const ShimmerListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      period: const Duration(milliseconds: 1550),
      child: ListTile(
        leading: FittedBox(
          child: Container(
            width: context.horzSize(45),
            height: context.horzSize(45),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[700]! : Colors.grey[100]!,
              shape: BoxShape.circle,
            ),
          ),
        ),
        title: Container(
          width: double.infinity,
          height: context.vertSize(16),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        subtitle: Container(
          width: context.horzSize(150),
          height: context.vertSize(14),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Iconsax.edit,
            size: context.horzSize(20),
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
