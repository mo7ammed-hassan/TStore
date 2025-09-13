import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/presentation/widgets/card_item_widget.dart';
import 'package:t_store/features/payment/routes/payment_routes.dart';

class ManageCardsScreen extends StatelessWidget {
  const ManageCardsScreen({super.key, this.nestedNavigator = true});
  final bool nestedNavigator;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final order = ModalRoute.of(context)?.settings.arguments as OrderEntity?;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : AppColors.light,
      appBar: TAppBar(
        title: 'Bank Account',
        showBackArrow: true,
        nestedNavigator: nestedNavigator,
      ),
      body: Padding(
        padding: context.responsiveInsets.all(TSizes.spaceBtwItems),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: 1,
                itemBuilder: (context, index) => const CardItemWidget(),
                separatorBuilder: (context, index) =>
                    ResponsiveGap.vertical(16),
              ),
            ),
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => nestedNavigator
                      ? Navigator.pushNamed(
                          context,
                          PaymentRoutes.creditCardScreen,
                          arguments: order,
                        )
                      : () {},
                  child: const ResponsiveText('Add Bank Card'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
