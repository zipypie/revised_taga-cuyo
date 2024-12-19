import 'package:flutter/widgets.dart';

class ScreenUtils {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context, {double subtract = 0}) {
    return MediaQuery.of(context).size.height - subtract;
  }
}
