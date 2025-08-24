import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/circular_conatiner.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });
  final String text;
  final bool selected;
  final void Function(bool)? onSelected;
  @override
  Widget build(BuildContext context) {
    final isColor = HelperFunctions.getColor(text);
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor != null
            ? const SizedBox()
            : ResponsiveText(
                text,
                fontSize: 13,
              ),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? AppColors.white : null),
        avatar: isColor != null
            ? TCircularContainer(
                width: 55,
                height: 55,
                backgroundColor: isColor,
              )
            : null,
        shape: isColor != null ? const CircleBorder() : null,
        labelPadding: isColor != null ? const EdgeInsets.all(0) : null,
        padding: isColor != null ? const EdgeInsets.all(0) : null,
        backgroundColor: isColor,
      ),
    );
  }
}
