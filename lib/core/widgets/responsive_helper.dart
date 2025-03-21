import 'package:flutter/material.dart';

class ResponsiveHelper {
  static Widget buildResponsiveUI({
    required Widget mobile,
     Widget? tablet,
    required Widget web,
    required BuildContext context,
  }) {
    double width = MediaQuery.of(context).size.width;

    if (width >= 1024) {
      return web; 
    } else if (width >= 600) {
      return tablet??mobile; 
    } else {
      return mobile; 
    }
  }
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }
}
