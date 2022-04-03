import 'package:flutter/cupertino.dart';

/// Utility class to create horizontal or vertical transparent spaces using SizedBox
class TransparentDivider {
  /* Divider - WIDTH */

  /// Sized Box whose width is determined by the argument width
  static SizedBox w(double width) {
    return SizedBox(
      width: width,
    );
  }

  /// Sized Box with a 10.0 width
  static SizedBox w10() {
    return const SizedBox(
      width: 10.0,
    );
  }

  /* Divider - HEIGHT */

  /// Sized Box whose height is determined by the argument height
  static SizedBox h(double height) {
    return SizedBox(
      height: height,
    );
  }

  /// Sized Box with a 10.0 height
  static SizedBox h10() {
    return const SizedBox(
      height: 10.0,
    );
  }
}
