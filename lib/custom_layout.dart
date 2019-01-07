import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class HorizontalAlignment {
  final double x;

  const HorizontalAlignment._(this.x)
      : assert(x != null);

  static const HorizontalAlignment left = HorizontalAlignment._(-1.0);
  static const HorizontalAlignment right = HorizontalAlignment._(1.0);
  static const HorizontalAlignment center = HorizontalAlignment._(0.0);

  double calculateX(double containerWidth, double width, double margin) {
    final double center = containerWidth / 2.0;
    if (x == 0)
      return center - width / 2.0;
    return math.max(margin, center + x * center - width - margin);
  }
}

class CustomLayoutParentData extends ContainerBoxParentData<RenderBox> {

}

class RenderCustomLayoutBox extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, CustomLayoutParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, CustomLayoutParentData> {

  RenderCustomLayoutBox({
    List<RenderBox> children,
    HorizontalAlignment alignment = HorizontalAlignment.left,
    double margin = 0.0
  }) : _alignment = alignment,
       _margin = margin {
    addAll(children);
  }

  HorizontalAlignment get alignment => _alignment;
  HorizontalAlignment _alignment;
  set alignment(HorizontalAlignment value) {
    assert(value != null);
    if (_alignment == value)
      return;
    _alignment = value;
    markNeedsLayout();
  }

  double get margin => _margin;
  double _margin;
  set margin(double value) {
    assert(value != null);
    if (_margin == value)
      return;
    _margin = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! CustomLayoutParentData) {
      child.parentData = CustomLayoutParentData();
    }
  }

  double _getIntrinsicHeight(double childSize(RenderBox child)) {
    double inflexibleSpace = 0.0;
    RenderBox child = firstChild;
    while (child != null) {
      if (child == lastChild)
        break;
      inflexibleSpace += childSize(child);
      final FlexParentData childParentData = child.parentData;
      child = childParentData.nextSibling;
    }
    return inflexibleSpace;
  }

  double _getIntrinsicWidth(double childSize(RenderBox child)) {
    double maxSpace = 0.0;
    RenderBox child = firstChild;
    while (child != null) {
      if (child == lastChild)
        break;
      maxSpace = math.max(maxSpace, childSize(child));
      final FlexParentData childParentData = child.parentData;
      child = childParentData.nextSibling;
    }
    return maxSpace;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return _getIntrinsicWidth((RenderBox child) => child.getMinIntrinsicWidth(height));
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _getIntrinsicWidth((RenderBox child) => child.getMaxIntrinsicWidth(height));
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return _getIntrinsicHeight((RenderBox child) => child.getMinIntrinsicHeight(width));
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return _getIntrinsicHeight((RenderBox child) => child.getMaxIntrinsicHeight(width));
  }

  @override
  void performLayout() {
    if (childCount == 0) {
      size = constraints.biggest;
      assert(size.isFinite);
      return;
    }

    double width = constraints.maxWidth;
    double height = 0;

    RenderBox child = firstChild;
    while (child != null) {
      if (child == lastChild)
        break;

      final CustomLayoutParentData childParentData = child.parentData;

      child.layout(BoxConstraints.tightFor(width: width), parentUsesSize: true);
      childParentData.offset = Offset(0, height);

      final Size childSize = child.size;
      width = math.max(width, childSize.width);
      height += childSize.height;

      child = childParentData.nextSibling;
    }

    size = Size(width, height);

    lastChild.layout(BoxConstraints(maxWidth: width, maxHeight: height), parentUsesSize: true);
    final CustomLayoutParentData childParentData = lastChild.parentData;
    final double prevY = height - childParentData.previousSibling.size.height;
    final double x = _alignment.calculateX(size.width, lastChild.size.width, margin);
    childParentData.offset = Offset(x, prevY - lastChild.size.height / 2);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(HitTestResult result, { Offset position }) {
    return defaultHitTestChildren(result, position: position);
  }
}

class CustomLayout extends MultiChildRenderObjectWidget {
  /// Creates a custom multi-child layout.
  CustomLayout({
    Key key,
    this.alignment = HorizontalAlignment.left,
    this.margin = 0.0,
    List<Widget> children = const <Widget>[],
  }) : super(key: key, children: children);

  final HorizontalAlignment alignment;
  final double margin;

  @override
  RenderCustomLayoutBox createRenderObject(BuildContext context) {
    return RenderCustomLayoutBox(alignment: alignment, margin: margin);
  }

  @override
  void updateRenderObject(BuildContext context, RenderCustomLayoutBox renderObject) {
    renderObject
      ..alignment = alignment
      ..margin = margin;
  }
}
