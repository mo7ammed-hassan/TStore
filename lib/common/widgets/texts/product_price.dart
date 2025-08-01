import 'package:flutter/material.dart';

class TProductPriceText extends StatelessWidget {
  const TProductPriceText({
    super.key,
    this.currencySign = '\$',
    required this.price,
    this.isLarge = false,
    this.maxLines = 1,
    this.lineThrough = false,
  });

  final String currencySign;
  final String price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$currencySign$price',
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.bodyLarge!.apply(
                decoration: lineThrough ? TextDecoration.lineThrough : null,
              )
          : Theme.of(context).textTheme.bodyLarge!.apply(
                decoration: lineThrough ? TextDecoration.lineThrough : null,
              ),
    );
  }
}
