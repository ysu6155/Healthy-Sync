import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/MyApp.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(
      Myapp(),
  );
}
///flutter pub run easy_localization:generate -S assets/translations -O lib/view_model/translations -o locale_keys.g.dart -f keys
///flutter pub run intl_translation:generate_from_arb --output-dir=lib/view_model/translations --no-use-deferred-loading lib/main.dart lib/view_model/translations/intl_*.arb
///
///
/// dart run intl_translation:generate_from_arb --output-dir=lib/view_model/translations --no-use-deferred-loading lib/main.dart lib/view_model/translations/intl_en.arb lib/view_model/translations/intl_ar.arb