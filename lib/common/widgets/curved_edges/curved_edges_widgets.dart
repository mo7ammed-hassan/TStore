import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/curved_edges/custom_curved_edges.dart';

class TCurvedEdgeWidget extends StatelessWidget {
  final Widget? child;
  const TCurvedEdgeWidget({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TCustomCurvedEdges(),
      child: child,
    );
  }
}
