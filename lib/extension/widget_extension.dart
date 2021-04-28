import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

extension WidgetExtensions on Widget {
  Widget padding({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Widget constrained({double maxHeight = double.infinity, double maxWidth = double.infinity}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
      child: this,
    );
  }
}
