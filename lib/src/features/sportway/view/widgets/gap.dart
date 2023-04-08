import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _RenderGap extends RenderBox {
  _RenderGap({
    double? mainAxisExtent,
  }) : _mainAxisExtent = mainAxisExtent!;

  double get mainAxisExtent => _mainAxisExtent;
  double _mainAxisExtent;

  set mainAxisExtent(double value) {
    if (_mainAxisExtent != value) {
      _mainAxisExtent = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    final flex = parent!;
    if (flex is RenderFlex) {
      if (flex.direction == Axis.horizontal) {
        size = constraints.constrain(Size(mainAxisExtent, 0));
      } else {
        size = constraints.constrain(Size(0, mainAxisExtent));
      }
    } else {
      throw FlutterError('Gap widget is not inside a Flex parent');
    }
  }
}

class Gap extends LeafRenderObjectWidget {
  const Gap(
    this.mainAxisExtent, {
    super.key,
  }) : assert(mainAxisExtent >= 0 && mainAxisExtent <= double.infinity);

  final double mainAxisExtent;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderGap(mainAxisExtent: mainAxisExtent);
  }

  @override
  // ignore: library_private_types_in_public_api
  void updateRenderObject(BuildContext context, _RenderGap renderObject) {
    renderObject.mainAxisExtent = mainAxisExtent;
  }
}
