import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizeExtension on num {
  SizedBox get H => SizedBox(height: toDouble().sp);

  SizedBox get W => SizedBox(width: toDouble().w);
}

extension PaddingExtension on Widget {
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: this);

  Widget paddingOnly(
          {double left = 0,
          double right = 0,
          double top = 0,
          double bottom = 0}) =>
      Padding(
          padding: EdgeInsets.only(
              left: left, right: right, top: top, bottom: bottom),
          child: this);

  Widget paddingDirectional(
          {double start = 0,
          double end = 0,
          double top = 0,
          double bottom = 0}) =>
      Padding(
        padding: EdgeInsetsDirectional.only(
            start: start, end: end, top: top, bottom: bottom),
        child: this,
      );
}

extension VisibilityExtension on Widget {
  Widget visible(bool isVisible) => isVisible ? this : SizedBox.shrink();
}

extension BorderExtension on Widget {
  Widget withBorder(
      {Color color = Colors.black, double width = 1.0, double radius = 8.0}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color, width: width),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: this,
    );
  }

  Widget withShadow(
      {Color color = Colors.black26,
      double blurRadius = 6.0,
      double spreadRadius = 2.0,
      Offset offset = const Offset(2, 2)}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: color,
              blurRadius: blurRadius,
              spreadRadius: spreadRadius,
              offset: offset),
        ],
      ),
      child: this,
    );
  }
}

extension ScrollableExtension on Widget {
  Widget scrollable({Axis axis = Axis.vertical}) {
    return SingleChildScrollView(
      scrollDirection: axis,
      child: this,
    );
  }
}

extension InkTapEffect on Widget {
  Widget withTapEffect({
    required VoidCallback onTap,
    Color? splashColor,
    Color? highlightColor,
    double borderRadius = 12.0,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: splashColor ?? Colors.white.withValues(alpha: 0.3),
        highlightColor: highlightColor ?? Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(borderRadius.r),
        onTap: onTap,
        child: this,
      ),
    );
  }
}

extension NavigationExtensions on BuildContext {
  /// الانتقال إلى صفحة جديدة
  void push(Widget page) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => page));
  }

  /// الانتقال إلى صفحة جديدة مع إزالة الصفحة الحالية
  void pushReplacement(Widget page) {
    Navigator.pushReplacement(
        this, MaterialPageRoute(builder: (context) => page));
  }


  /// الرجوع للصفحة السابقة
  void pop() {
    Navigator.pop(this);
  }

  void pushAndRemoveUntil(Widget page) {
    Navigator.pushAndRemoveUntil(
        this, MaterialPageRoute(builder: (context) => page), (route) => false);
  }
}
