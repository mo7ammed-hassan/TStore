import 'package:flutter/material.dart';
import 'package:t_store/features/shop/features/payment/data/models/payment_method.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class PaymentMethodCard extends StatelessWidget {
  final PaymentMethod method;
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
          padding: const EdgeInsets.all(8),
          decoration: _buildCardDecoration(isDark),
          child: Row(
            children: [
              _buildLogoBox(context),
              const SizedBox(width: 16),
              _buildInfoSection(context),
              _buildSelectionIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  // --- UI parts ---

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
      width: MediaQuery.of(context).size.width * 0.24,
      height: 60,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(method.icon, fit: BoxFit.contain),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            method.name,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const Text(
            '**** **** 1234',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionIndicator() {
    return AnimatedContainer(
      duration: _animationDuration,
      width: 24,
      height: 24,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? Colors.transparent : Color(0xFF007df3),
          width: selected ? 0 : 4,
        ),
        boxShadow: [
          if (selected)
            BoxShadow(
              color: Color(0xFF007df3).withValues(alpha: 0.4),
              blurRadius: 0,
              offset: const Offset(0, 0),
            )
        ],
      ),
      child: AnimatedContainer(
        duration: _animationDuration,
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: selected
              ? Color(0xFF007df3).withValues(alpha: 0.9)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
