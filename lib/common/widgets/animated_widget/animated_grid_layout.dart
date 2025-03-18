import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AnimatedGridLayout extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double mainAxisExtent;
  final Widget Function({
    bool? isVisible,
    VoidCallback? onRemove,
    VoidCallback? onAdd,
    required Widget child,
  }) animatedEffect;

  const AnimatedGridLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisExtent = 290,
    required this.animatedEffect,
  });

  @override
  State<AnimatedGridLayout> createState() => _AnimatedGridLayoutState();
}

class _AnimatedGridLayoutState extends State<AnimatedGridLayout> {
  final List<int> visibleItems = [];

  @override
  void initState() {
    super.initState();
    _animateAddItems();
  }

  void _animateAddItems() {
    for (int i = 0; i < widget.itemCount; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) {
          setState(
            () {
              if (!visibleItems.contains(i)) visibleItems.add(i);
            },
          );
        }
      });
    }
  }

  void removeItem(int index) {
    setState(() {
      visibleItems.remove(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSizes.gridViewSpacing, //vertical
        crossAxisSpacing: AppSizes.gridViewSpacing,
        mainAxisExtent: widget.mainAxisExtent,
      ),
      itemBuilder: (context, index) {
        return widget.animatedEffect(
          isVisible: visibleItems.contains(index),
          onRemove: () => removeItem(index),
          onAdd: () => _animateAddItems(),
          child: widget.itemBuilder(context, index),
        );
      },
    );
  }
}
