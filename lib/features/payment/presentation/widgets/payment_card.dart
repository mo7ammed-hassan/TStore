import 'package:flutter/material.dart';
import 'package:t_store/features/payment/domain/entities/card_method_entity.dart';
import 'package:t_store/core/core.dart';
import 'package:t_store/features/payment/presentation/widgets/selection_indicator.dart';

class PaymentMethodCard extends StatelessWidget {
  final CardMethodEntity method;
  final bool selected;
  final VoidCallback onTap;

  const PaymentMethodCard({
    super.key,
    required this.method,
    required this.selected,
    required this.onTap,
  });

  // constants
  static const _animationDuration = Duration(milliseconds: 250);
  static const _selectedScale = 1.05;
  static const _unselectedScale = 1.0;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedScale(
        scale: selected ? _selectedScale : _unselectedScale,
        duration: _animationDuration,
        curve: Curves.easeOut,
        child: Container(
          padding: context.responsiveInsets.all(8),
          decoration: _buildCardDecoration(isDark),
          child: Row(
            children: [
              _buildLogoBox(context),
              ResponsiveGap.horizontal(16),
              _buildInfoSection(context),
              SelectionIndicator(selected: selected),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildCardDecoration(bool isDark) {
    return BoxDecoration(
      color: isDark ? AppColors.dark : Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: isDark ? AppColors.dark : Colors.grey.shade200,
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _buildLogoBox(BuildContext context) {
    return Container(
      width: context.horzSize(90),
      height: context.vertSize(60),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(method.logoUrl, fit: BoxFit.contain),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Expanded(
      child: ResponsiveText(
        method.name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
